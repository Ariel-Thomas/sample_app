require 'spec_helper'

describe "MicropostPages" do

  subject { page }

  let (:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.should_not change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.should change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete"   }.should change(Micropost, :count).by(-1)
      end
    end
  end

  describe "micropost sidebar" do
    before { visit root_path }

    describe "has base character count" do
      it { should have_content("140 characters remain") }
    end

    describe "updates the character count", js: true do
      before { fill_in "micropost_content", with: "a" }

      it { should have_content("139 characters remain") }
    end

    describe "character count will not go under 0", js: true do
      before { fill_in "micropost_content", with: "a" * 141 }

      it { should have_content("0 characters remain") }
    end
  end
end
