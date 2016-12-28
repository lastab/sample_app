require 'rails_helper'

describe MicropostsController do
  fixtures :users, :microposts

  subject(:micropost) { microposts(:orange) }
  let(:user) { users(:michael) }

  it "should redirect create when not logged in" do
    expect { post :create, id: user.id}.to change{ Micropost.count}.by(0)
    expect(response).to redirect_to(login_url)
  end

  it "should redirect destroy when not logged in" do
    expect { delete :destroy, id: user.id}.to change{ Micropost.count}.by(0)
    expect(response).to redirect_to(login_url)
  end

  it "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    expect { delete :destroy, id: user.id}.to change{ Micropost.count}.by(0)
    expect(response).to redirect_to(root_url)
  end
end
