require 'faraday'
require 'json'
require 'hashie'

require_relative 'client/errors'

class AmoCRM::Client
  PREFIX_PATH = '/private/api/v2/json/'

  SESSION_TIMEOUT = 15*60 # 15 minutes - https://developers.amocrm.ru/rest_api/auth.php

  def initialize url:
    @connection = Faraday.new url
    # 'private/api/v2/json/'
    # connection.use :cookie_jar
    # connection.response :logger
    connection.request :url_encoded
  end

  def authorize(user_login: , user_hash: )
    logger.debug "Client: Authorize #{user_login}"
    path = "private/api/auth.php?type=json"
    data = { USER_LOGIN: user_login, USER_HASH: user_hash }
    @user_login = user_login
    @user_hash = user_hash
    response = connection.post path, data
    # Success reponse header example:
    # "set-cookie"=> "session_id=nic2a7t2mauuooc8a45pbm3p85nlf1nm9tr4cltpfl3r5kfk4um0; path=/; domain=.amocrm.ru, BITRIX_SM_LOGIN=danil%40brandymint.ru; expires=Thu, 26-Aug-2021 13:34:47 GMT; Max-
    # "expires"=>"Thu, 19 Nov 1981 08:52:00 GMT",
    #
    # Success response body example:
    # "{\"response\":{\"auth\":true,\"accounts\":[{\"id\":\"11413681\",\"name\":\"Kiosk\",\"subdomain\":\"kiosk\",\"language\":\"ru\",\"timezone\":\"Europe\\/Moscow\"}],\"server_time\":1474464887}}"
    @authorized_at = Time.zone.now
    @cookie = response.headers['set-cookie']
    logger.debug "Client: Authorization response #{response.body}"
    validate response
  end

  def authorize!(user_login: , user_hash: )
    res = authorize user_login: user_login, user_hash: user_hash
    raise "AmoCRM is not authorized #{res.inspect}" unless res.auth

    res
  end

  def get path, params={}
    logger.debug "Client: GET #{path} #{params}"
    check_authorization!
    validate connection.get PREFIX_PATH + path, params, { Cookie: cookie }
  end

  def post path, data=nil
    data = JSON.generate data.as_json
    logger.debug "Client: POST #{path}: #{data}"
    check_authorization!
    validate connection.post PREFIX_PATH + path, data, { 'Content-Type' => 'application/json', Cookie: cookie }
  end

  def put path, data
    data = JSON.generate data.as_json
    logger.debug "Client: PUT #{path}: #{data}"
    check_authorization!
    validate connection.put PREFIX_PATH + path, data, { 'Content-Type' => 'application/json', Cookie: cookie }
  end

  def delete path
    check_authorization!
    validate connection.delete PREFIX_PATH path
  end

  private

  attr_reader :connection, :cookie

  def check_authorization!
    return true unless session_expired?
    raise 'No user_login to reauthorize' unless @user_login
    res = authorize user_login: @user_login, user_hash: @user_hash
    raise "AmoCRM is not reauthorized #{res.inspect}" unless res.auth

    res
  end

  def session_expired?
    return !cookie || !@authorized_at || @authorized_at + SESSION_TIMEOUT <= Time.zone.now
  end

  def logger
    AmoCRM.logger
  end

  def validate res
    AmoCRM::Client::Errors.build res unless res.status == 200

    data = JSON.parse(res.body)['response']
    Hashie::Mash.new data
  end
end
