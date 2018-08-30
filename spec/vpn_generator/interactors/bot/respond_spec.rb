RSpec.describe Interactors::Bot::Respond do
  let(:bot) { instance_double('Telegram::Bot::Client', api: api) }
  let(:markup) { instance_double('Telegram::Bot::Types::ReplyKeyboardMarkup') }
  let(:args) { Hash[user: user, text: 'Hello', reply_markup: markup] }
  let(:user) { User.new(messenger_id: 123) }
  let(:api) { double('Telegram::Bot::Api') }
  subject { described_class.new(bot: bot) }

  it 'calls bot with right args' do
    expect(api).to receive(:send_message).with(
      chat_id: user.messenger_id,
      text: args[:text],
      reply_markup: args[:reply_markup]
    )
    subject.call **args
  end

  context 'be success' do
    it 'with reply markup' do
      expect(api).to receive(:send_message).with(
        chat_id: args[:user].messenger_id,
        text: args[:text],
        reply_markup: args[:reply_markup]
      )
      expect(subject.call(**args)).to be_a_success
    end

    it 'with reply markup' do
      expect(api).to receive(:send_message).with(
        chat_id: args[:user].messenger_id,
        text: args[:text],
        reply_markup: nil
      )
      expect(subject.call(user: user, text: args[:text])).to be_a_success
    end
  end
end
