require 'hanami/interactor'

module Interactors
  module Vpn
    class Email
      include Hanami::Interactor
      expose :email

      def call
        get_email! until verify_email
      end

      private

      def verify_email
        verify_response.body.eql? 'K'
      end

      def verify_response
        RestClient.post(
          'https://hidemyna.me/api/mailcheck.php',
          encoded_form_params,
          content_type: 'application/x-www-form-urlencoded'
        )
      end

      def get_email!
        puts "Getting email..."
        mail = RestClient.get('https://tempm.com/email-generator')
        html = Nokogiri::HTML(mail.body)
        node = html.xpath("//span[@id='email_ch_text']")
        @email = node.text
      rescue StandardError
        puts 'Timeout error'
        get_email!
      end

      def encoded_form_params
        URI.encode_www_form({ mail: @email })
      end
    end
  end
end
