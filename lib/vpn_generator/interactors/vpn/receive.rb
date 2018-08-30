# require 'rest-client'
# require 'nokogiri'
# require 'pry'
# require 'json'
# require 'capybara'
# require 'mechanize'

# class GetVpn
#   def call
#     email = valid_email
#     proxy = get_proxy
#     submit_form_with(email, proxy)
#     get_code email
#   end

#   def submit_form_with(email, proxy)
#     puts "Submitting form..."
#     agent = Mechanize.new
#     agent.log = Logger.new "mech.log"
#     agent.user_agent_alias = 'Mac Safari'
#     agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
#     agent.set_proxy(proxy['ip'], proxy['port'])
#     page = agent.get('https://hidemyna.me/ru/demo/')
#     form = page.forms.first
#     form.field_with(name: "demo_mail").value = email
#     form.submit
#     puts "Done"
#   end

#   def encoded_form_params(email)
#     URI.encode_www_form params(email)
#   end

#   def params(email)
#     {
#       mail: email
#     }
#   end

#   def get_proxy
#     puts 'Obitaining proxy...'
#     @proxy = JSON.parse(RestClient.get('https://gimmeproxy.com/api/getProxy').body)
#     puts "Done: #{@proxy['ip']}:#{@proxy['port']}"
#     @proxy
#   end

#   def get_code(email)
#     puts "Requesting code..."
#     page = RestClient.get("https://tempm.com/#{email}")
#     html = Nokogiri::HTML(page.body)
#     str = html.xpath("//div[@class='e7m mess_bodiyy']/span[1]").text
#     puts 'Done!'
#     puts "Your code is: #{str.rpartition(': ').last}"
#   end

#   def valid_email
#     puts 'Getting valid email...'
#     loop do
#       @email = temp_email
#       puts "Done: #{@email}"
#       break @email if verify_email(@email).body.eql? 'K'
#     end
#   end

#   def verify_email(email)
#     RestClient.post('https://hidemyna.me/api/mailcheck.php', encoded_form_params(email), :content_type => 'application/x-www-form-urlencoded')
#   end

#   def temp_email
#     mail = RestClient.get('https://tempm.com/email-generator')
#     html = Nokogiri::HTML(mail.body)
#     node = html.xpath("//span[@id='email_ch_text']")
#     node.text
#   end
# end

# GetVpn.new.call
