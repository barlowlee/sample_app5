require 'spec_helper'  # enables rspec and spork

describe "Static pages" do

#  let(:base_title) { 'ROR Tut. Samp. App'}

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: foo) }
    it { should have_title(full_title(bar)) }
  end

  describe "Home page" do
    before { visit root_path }

    #   it { should have_content('Sample App') } 

    let(:foo) { 'Sample App' }
    let(:bar) { '' }
    it_should_behave_like "all static pages"


    it { should have_title(full_title('')) }
    it { should_not have_title('|') }
    # the more verbose way of doing the same thing:
    # it "should have the content 'Sample App'" do
    #    expect(page).to have_content('Sample App')
    # end
    # it "should have the right title" do
    #    expect(page).to have_title("#{base_title}")
    #   # Took out "  | Home" with addition of the full_title helper
    # end
    # it "should not have a custom page title" do
    #    expect(page).not_to have_title('|')
      # note that 'have_title' searches for a substring 
      # not a perfect match, so the test fails if there's a '|'
      # anywhere in the title
    # end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "- follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end
        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
 

 # Eliminated this intermediate step with the 'full_title'
 #   method, defined in spec/support/utilities.rb
 #   old syntax below:
 #   it { should have_title("#{base_title} | Help") }
  end

  describe "About page" do
    before { visit about_path }
    it { should have_content('About Us') }
    it { should have_title(full_title('About')) }
  end

  describe "Contact page" do
    before { visit contact_path }
    it { should have_content('Contact Us') }
    it { should have_title(full_title('Contact Us')) }
  end

  it  "should have the right links on the layout"  do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Home"
    expect(page).to have_title(full_title(''))
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end

end
