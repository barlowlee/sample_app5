require 'spec_helper'  # enables rspec and spork

describe "User pages" do

	subject { page }

  describe "profile page" do
		# Replace with a factory-created user here
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_content(user.name) }
		it { should have_title(user.name) }
  end

	describe "- navigating to the signup page" do
		before { visit signup_path }

		it { should have_content('Sign up') }
		it { should have_title(full_title('Sign up')) }
		# remember that full_title is stored in 
		#		helpers/application_helper.rb
  end

  describe "- trying to sign up" do
		before { visit signup_path }
		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect do
					click_button submit
				end.not_to change(User, :count)
			end

			describe "- after submission" do
				before { click_button submit }
				it { should have_title("Sign up") }
				it { should have_content("error") }
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name", with: "Example User"
				fill_in "Email", with: "user@example.com"
				fill_in "Password", with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end

			it "should create a user" do
				expect do
					click_button submit
				end.to change(User, :count).by(1)
			end

			describe "- after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: "user@example.com") }
				it { should have_title(user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
			end
		end
  end
end
