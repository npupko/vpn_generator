require 'spec_helper'

RSpec.describe Interactors::Users::Create, type: :interactors do
  let(:user_repo) { instance_double('UserRepository') }
  let(:user) { User.new(messenger_id: user_data[:id]) }
  let(:user_data) {
    Hash[
      id: 229517892,
      is_bot: false,
      first_name: "Nikita",
      last_name: "Pupko",
      username: "LazyNick",
      language_code: "en-BY"
    ]
  }

  subject { described_class.new(user_repo: user_repo) }

  it 'create user if not exists' do
    expect(user_repo).to receive(:find_by).with({ messenger_id: user_data[:id] }).and_return nil
    expect(user_repo).to receive(:create_from_telegram_webhook).with(user_data).and_return user
    expect(subject.call(user_data)).to be_a_success
  end

  it 'return user if exists' do
    expect(user_repo).to receive(:find_by).with({ messenger_id: user_data[:id] }).and_return user
    expect(user_repo).to_not receive(:create_from_telegram_webhook).with(user_data)
    expect(subject.call(user_data)).to be_a_success
  end
end
