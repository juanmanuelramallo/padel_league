FactoryBot.define do
  factory :player do
    name { "Leo Augsburger" }
    phone { "+54123456789" }
    sequence(:email) { |n| "player-#{n}@example.com" }
    confirmation_token { SecureRandom.urlsafe_base64(24) }

    trait :confirmed do
      confirmed_at { Time.zone.now }
      confirmation_token { nil }
    end
  end
end
