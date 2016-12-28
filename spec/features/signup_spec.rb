require 'rails_helper'

describe "User Signup", type: feature do
  before do
    visit '/signup'
  end

  it "should display error for invalid information" do
    fill_in "user[name]", with: ""
    fill_in "user[email]", with: "example@user.com"
    fill_in "user[password]", with: "password1"
    fill_in "user[password_confirmation]", with: "password2"
    click_button "Create my account"
    expect(current_path).to eq('/users')
    find(:css, 'div#error_explanation')  
  end

end