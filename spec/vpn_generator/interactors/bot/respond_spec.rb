RSpec.describe Interactors::Bot::Respond do
  let(:bot) { instance_double('Telegram::Bot::Client', api: api) }
  let(:markup) { instance_double('Telegram::Bot::Types::ReplyKeyboardMarkup') }
  let(:args) { Hash[user: user, template: template] }
  let(:user) { User.new(messenger_id: 123) }
  let(:template) { instance_double('Templates::Greetings', text: 'Hello!', reply_markup: markup) }
  let(:template_without_markup) { OpenStruct.new(text: template.text) }
  let(:api) { double('Telegram::Bot::Api') }
  subject { described_class.new(bot: bot) }

  it 'calls bot with right args' do
    expect(api).to receive(:send_message).with(
      chat_id: user.messenger_id,
      text: template.text,
      reply_markup: template.reply_markup
    )
    subject.call **args
  end

  context 'be success' do
    it 'with reply markup' do
      expect(api).to receive(:send_message).with(
        chat_id: user.messenger_id,
        text: template.text,
        reply_markup: template.reply_markup
      )
      expect(subject.call(**args)).to be_a_success
    end

    it 'with reply markup' do
      expect(api).to receive(:send_message).with(
        chat_id: user.messenger_id,
        text: template.text,
        reply_markup: nil
      )
      expect(subject.call(user: user, template: template_without_markup)).to be_a_success
    end
  end
end
