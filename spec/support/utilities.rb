include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Email",  with: user.email
  fill_in "Password",  with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well
  cookies[:remember_token] = user.remember_token
end

def field_error_check(field, content)
  describe "should have an error for invalid #{field}" do
    before do
      fill_in field, with: content 
      click_button submit      
    end  
    
    it { should have_selector('title', text: 'Sign up' ) }
    it { should have_content('error') }
  end
end