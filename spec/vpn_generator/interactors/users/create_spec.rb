require 'spec_helper'

RSpec.describe Interactors::Users::Create, type: :interactors do
  let(:user_repo) { instance_double('UserRepository') }
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

  it 'calls user_repo wit hright args' do
    expect(user_repo).to_not receive(:create_from_telegram_webhook).with user_data
    expect(subject.call(user_data)).to be_a_success
  end
end
