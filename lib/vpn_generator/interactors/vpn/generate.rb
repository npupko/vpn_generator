require 'hanami/interactor'

module Interactors
  module Vpn
    class Generate
      include Hanami::Interactor
      include Import['proxy_repo', 'vpn.email']

      expose :key

      def call
        email_generator = email.call
        submit_form_with(email_generator.email)
        @key = get_code email_generator.email
        while @key.empty? do
          puts 'Empty key'
          @key = get_code email_generator.email
        end
      end

      def submit_form_with(email)
        puts 'Form submitting...'
        configure_agent!
        form = page.forms.first until form
        puts 'Form found'
        form.field_with(name: "demo_mail").value = email
        puts 'Field filled'
        form.submit
        puts 'Form submitted'
      end

      def page
        puts 'Load hidemyname page'
        temp_proxy = proxy
        agent.set_proxy(temp_proxy.ip, temp_proxy.port)
        agent.get('https://hidemyna.me/ru/demo/')
      rescue
        puts "Wrong proxy"
        page
      end

      def proxy
        proxy_repo.get_fresh
      end

      def configure_agent!
        agent.log = Logger.new "mech.log"
        agent.user_agent_alias = 'Mac Safari'
        agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      def agent
        @agent ||= Mechanize.new
      end

      def get_code(email)
        page = RestClient.get("https://tempm.com/#{email}")
        html = Nokogiri::HTML(page.body)
        str = html.xpath("//div[@class='e7m mess_bodiyy']/span[1]").text
        parse(str)
      end

      def parse(code)
        code.rpartition(': ').last
      end
    end
  end
end

