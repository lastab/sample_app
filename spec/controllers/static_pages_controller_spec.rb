require 'rails_helper'

describe StaticPagesController do
  let(:base_title) { "Ruby on Rails Sample App" }


  it "should get root" do
    get :home
    expect(response).to be_success
  end

  it "should get help" do
    get :help
    expect(response).to be_success
  end

  it "should get about" do
    get :about
    expect(response).to be_success
  end

  it "should get contact" do
    get :contact
    expect(response).to be_success
  end
end
