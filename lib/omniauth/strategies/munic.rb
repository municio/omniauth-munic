# frozen_string_literal: true

module OmniAuth
  module Strategies
    autoload :Munic, 'omniauth/strategies/munic'

    # MunicIO strategy
    class Munic < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'munic'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, site: 'https://connect.munic.io'

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['uid'] }

      info do
        i = {
          email: raw_info['email'],
          full_name: raw_info['full_name'],
          language: raw_info['language'],
          organization_id: raw_info['organization_id'],
          organization_name: raw_info['organization_name']
        }
        i[:time_zone] = raw_info['time_zone'] unless raw_info['time_zone'].nil?
        i[:company_name] = raw_info['company_name'] unless raw_info['company_name'].nil?
        i
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/users/me.json').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
