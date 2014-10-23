# Hard coding a single user

# FactoryGirl.define do
# 	factory :user do
# 		name     "Fred Flintstone"
# 		email    "fred@flintstone.com"
# 		password "foobar"
# 		password_confirmation "foobar"
# 	end	
# end

# Generating a sequence of users

FactoryGirl.define do
	factory :user do
		sequence(:name)   { |n| "Person #{n}" }
		sequence(:email)  { |n| "person_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end
end