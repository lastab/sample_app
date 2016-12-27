require 'rails_helper'

describe Micropost do
  fixtures :users
  fixtures :microposts
  let(:user) { users(:michael) }
  subject(:micropost) { user.microposts.build(content: "Lorem ipsum") }

  it "should be valid" do
    expect(micropost).to be_valid
  end

  it "user id should be present" do
    micropost.user_id = nil
    expect(micropost).not_to be_valid
  end

  it "content should be present" do
    micropost.content = "   "
    expect(micropost).not_to be_valid
  end

  it "content should be at most 140 characters" do
    micropost.content = "a" * 141
    expect(micropost).not_to be_valid
  end

  it "order should be most recent first" do
    expect(microposts(:most_recent)).to be == Micropost.first
  end
end
