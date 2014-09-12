require 'spec_helper'

# I'm not sure what it means to describe a class.
#		This language is unlike other describe blocks.
#		Changing the class name from ApplicationHelper
#		To something else, and trying to change all other
#		uses of that class name wherever they may be
#		causes Spork to break.  Some under-the-hood Rails
#		automagic going on here that I don't understand??

describe ApplicationHelper do
	
	describe "full_title" do
		it "should include the page title" do
			expect(full_title("foo")).to match(/foo/)
		end

		it "should include the base title" do
			expect(full_title("foo")).to match(/^ROR Tut. Samp. App/)
		end

		it "should not include a bar for the home page" do
			expect(full_title("")).not_to match(/\|/)
		end
	end

end