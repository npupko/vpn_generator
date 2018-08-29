RSpec.describe UserRepository, type: :repository do
  let(:attributes) {
    Hash[
      messenger_id: 229517892,
      first_name: "Nikita",
      last_name: "Pupko",
      username: "LazyNick",
      language_code: "en-BY"
    ]
  }

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

  subject { described_class.new }

  it '#create_from_telegram_webhook' do
    expect(subject.create_from_telegram_webhook(user_data)).
      to include attributes
  end
end
