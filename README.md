# Adwords with Sinatra example
A simple app that interacts with Google's [Adword API](https://developers.google.com/adwords/api/).

## Usage
1. Get a developer token for the Adwords API from Google (this isn't an automatic process so takes a long time).
2. Create a new web application from Google's developer console. Be sure to set the redirect_uris parameter in the credentials. 
3. `git clone`
4. Put the required parameters (oauth2_client_id, oauth2_client_secret, oauth2_callback and developer_token) in the `config/adwords_api.yml` file (an example file is included in the adwords_api gem).
5. `bundle install`
6. `rackup config.ru`
7. Navigate to `http://localhost:9292/`