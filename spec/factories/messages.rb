FactoryBot.define do
  factory :message do
    content { "Message text" }
    room
    user
  end
end
