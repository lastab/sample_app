require 'rails_helper'

describe SessionsController, type: feature do
  fixtures :users
  let(:user) { users(:michael) }

  before(:each) do
    visit '/login'
  end
  it "signs me in" do
    # visit '/login'
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: 'password'
    click_button 'Log in'
    expect(current_path).to eq("/users/#{user.id}")
  end

  it "when password is blank" do
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: ''
    click_button 'Log in'
    expect(current_path).to eq("/login")
    expect(page).to have_content("Invalid email/password combination")
  end

  it "password reset" do
    # visit '/login'
    click_link "forgot password"
    fill_in "Email", :with => user.email
    click_button "Submit"
    expect(current_path).to eq('/')
    page.should have_content("Email sent with password reset instructions")
    expect(ActionMailer::Base.deliveries.size).to eq(1)
  end


end