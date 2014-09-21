FactoryGirl.define do
	factory :user do
		name     "Fred Flintstone"
		email    "fred@flintstone.com"
		password "foobar"
		password_confirmation "foobar"
	end	
end