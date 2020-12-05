FactoryBot.define do
  factory :user do
    email { Faker::Internet.email}
    password { 'password' }
    password_confirmation { 'password' }

    trait :with_friends do  
      transient do
        friend_count { 3 }
      end

      after(:create) do |user, evaluator|
        friends = create_list(:user, evaluator.friend_count)
        user.followers << friends
        user.followed << friends
      end
    end 
  end
end