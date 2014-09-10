require 'spec_helper'  # enables rspec and spork

describe "Static pages" do

#  let(:base_title) { 'ROR Tut. Samp. App'}

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Sample App') }    
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
    #   # note that 'have_title' searches for a substring 
      # not a perfect match, so the test fails if there's a '|'
      # anywhere in the title
    # end
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
end
