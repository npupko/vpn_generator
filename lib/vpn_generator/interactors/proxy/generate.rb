require 'hanami/interactor'

module Interactors
  module Proxy
    class Generate
      include Hanami::Interactor
      include Import['proxy_repo']

      def call
        puts "Generating proxy..."
        generate_proxy!
      end

      private

      def generate_proxy!
        proxy_list.each do |proxy|
          ip = proxy.match(/\A(.+):/)[1]
          port = proxy.match(/:(\d+)\s/)[1]
          proxy_repo.create_if_uniq(ip: ip, port: port)
        end
      end

      def test_request
        RestClient.get 'http://google.com'
      rescue
        false
      end

      def proxy_list
        @proxy_list ||= response.body.split("\n").drop(4).take(60)
      end

      def response
        # RestClient.get('https://gimmeproxy.com/api/getProxy')
        # RestClient.get('https://api.getproxylist.com/proxy')
        RestClient.get('http://spys.me/proxy.txt')
      end
    end
  end
end
