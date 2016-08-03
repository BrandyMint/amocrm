require 'json'

a = AmoCRM::Client.new url: ENV['AMOCRM_URL'] || 'https://kiosk.amocrm.ru'
a.authorize user_login: ENV['AMOCRM_LOGIN'], user_hash: ENV['AMOCRM_APIKEY']
account = a.get('accounts/current')['account']

File.write 'account.json', JSON.pretty_generate(account.as_json)
