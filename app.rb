require 'sinatra'
require 'adwords_api'

class App < Sinatra::Base

  CONFIG_FILE = 'config/adwords_api.yml'

	configure do
	  set :raise_errors, development?
    set :adwords,      AdwordsApi::Api.new(CONFIG_FILE)

    use Rack::Session::Cookie, :key          => 'rack.session',
                               :expire_after => 2592000, 
                               :secret       => 'gfangakdsfvihgwr5h43i534rt5bgkhboafbfgkhdfih'
	end

  helpers do 

    def adwords_api
      settings.adwords
    end

  end

	get '/' do		
    if session[:token]
      credentials = adwords_api.credential_handler
      credentials.set_credential(:oauth2_token, session[:token])

      campaign_srv = adwords_api.service(:CampaignService, :v201406)
      campaigns = campaign_srv.get({:fields => ['Id', 'Name', 'Status']})

      campaigns.inspect
    else
      session[:redirect] = request.path_info
      adwords_api.authorize{|auth_url| redirect auth_url }
    end     
	end

  get '/oauth2callback' do
    token = adwords_api.authorize(:oauth2_verification_code => params[:code])

    session[:token] = token
        
    redirect to session[:redirect]
  end  

end