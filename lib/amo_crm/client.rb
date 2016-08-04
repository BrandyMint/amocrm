require 'faraday'
require 'json'
require 'hashie'

require_relative 'client/errors'

class AmoCRM::Client
  PREFIX_PATH = '/private/api/v2/json/'

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
    response = connection.post path, data
    @cookie = response.headers['set-cookie']
    validate response
  end

  def authorize!(user_login: , user_hash: )
    res = authorize user_login: user_login, user_hash: user_hash
    raise "AmoCRM is not authorized #{res}" unless res.auth

    res
  end

  def get path, params={}
    logger.debug "Client: GET #{path} #{params}"
    validate connection.get PREFIX_PATH + path, params, { Cookie: cookie }
  end

  def post path, data=nil
    data = JSON.generate data.as_json
    logger.debug "Client: POST #{path}: #{data}"
    validate connection.post PREFIX_PATH + path, data, { 'Content-Type' => 'application/json', Cookie: cookie }
  end

  def put path, data
    data = JSON.generate data.as_json
    logger.debug "Client: PUT #{path}: #{data}"
    validate connection.put PREFIX_PATH + path, data, { 'Content-Type' => 'application/json', Cookie: cookie }
  end

  def delete path
    validate connection.delete PREFIX_PATH path
  end

  private

  attr_reader :connection, :cookie

  def logger
    AmoCRM.logger
  end

  def validate res
    AmoCRM::Client::Errors.build res unless res.status == 200

    data = JSON.parse(res.body)['response']
    Hashie::Mash.new data
  end
end
