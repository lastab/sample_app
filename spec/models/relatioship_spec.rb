require 'rails_helper'

describe Relationship do
  fixtures :users
  # fixtures :microposts
  subject(:relationship) {  Relationship.new(follower_id: users(:michael).id,
                                             followed_id: users(:archer).id) }
  it "should be valid" do
    expect(relationship).to be_valid
  end

  it "should require a follower_id" do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it "should require a followed_id" do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end

end
