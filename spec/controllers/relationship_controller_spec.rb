require 'rails_helper'

describe RelationshipsController do
  fixtures :relationships

  let(:one) { relationships(:one)}

  it "create should require logged-in user" do
    expect {post :create }.to change{ Relationship.count }.by(0)
    expect(response).to redirect_to(login_url)
  end

  it "destroy should require logged-in user" do
    expect {delete :destroy, id: one.id }.to change{ Relationship.count }.by(0)
    expect(response).to redirect_to(login_url)
  end

end
