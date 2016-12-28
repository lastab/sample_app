require 'rails_helper'

describe UsersController do
  fixtures :users

  let(:user) { users(:michael) }
  let(:other_user) { users(:archer) }

  it "should redirect index when not logged in" do
    get :index
    expect(response).to redirect_to(login_path)
  end

  it "should get new" do
    get :new
    expect(response).to be_success
  end

  it "should redirect edit when logged in as wrong user" do
    log_in_as(other_user)
    get :edit , id: user.id
    expect(flash.empty?).to be true
    expect(response).to redirect_to(root_url)
  end

  it "should redirect update when not logged in" do
    patch :update, id: user.id, name: user.name,
                                      email: user.email
    expect(flash.empty?).to be false
    expect(response).to redirect_to(login_url)
  end

  it "should redirect destroy when not logged in" do
    expect{ delete :destroy, id: user.id }.to change{ User.count }.by(0)
    expect(response).to redirect_to(login_url)
  end

  it "should redirect destroy when logged in as a non-admin" do
    log_in_as(other_user)
    expect{ delete :destroy, id: user.id }.to change{ User.count }.by(0)
    expect(response).to redirect_to(root_url)
  end

  it "should redirect following when not logged in" do
    get :following, id: user.id
    expect(response).to redirect_to(login_url)
  end

  it "should redirect followers when not logged in" do
    get :followers, id: user.id
    expect(response).to redirect_to(login_url)
  end

end
