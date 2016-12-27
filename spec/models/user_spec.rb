require 'rails_helper'

describe User do
  fixtures :users

  subject(:user) { User.new(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar")}
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it "name should be present" do
    user.name = " "
    expect(user).not_to be_valid
  end

  it "email should be present" do
    user.name = " "
    expect(user).not_to be_valid
  end

  it "name should  not be too long" do
    user.name = "a" * 51
    expect(user).not_to be_valid
  end

  it "email should not be too long" do
    user.name = ("a" * 255) + "@example.com"
    expect(user).not_to be_valid
  end

  it "should accept valid address" do
    valid_addresses = %w[user@example.xom USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it "should reject invalid address" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. first@bar_baz.com foo@bar_baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).not_to be_valid
    end

  end


  it "should only accept unique email" do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).not_to be_valid
  end

  it "should have password(nonblank)" do
    user.password = user.password_confirmation = " " * 6
    expect(user).not_to be_valid
  end

  it "password should have a minimum length" do
    user.password = user.password_confirmation = "a" * 5
    expect(user).not_to be_valid
  end

  it "authenticated? should return false for a user with nil digest" do
    expect(user.authenticated?(:remember, '')).to be_falsey
  end

  it "associated microposts should be destroyed" do
    user.save
    user.microposts.create!(content: "Lorem ipsum")
    expect { user.destroy }.to change{ Micropost.count }.by(-1)
  end

  it "should follow and unfollow a user" do
    michael = users(:michael)
    archer = users(:archer)
    expect(michael.following?(archer)).to be_falsey
    michael.follow(archer)
    expect(michael.following?(archer)).to be true
    expect(archer.followers.include?(michael)).to be true
    michael.unfollow(archer)
    expect(michael.following?(archer)).to be_falsey
  end

  it "feed should have the right posts" do
    michael = users(:michael)
    archer  = users(:archer)
    lana    = users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      expect(michael.feed.include?(post_following)).to be true
    end
    # Posts from self
    michael.microposts.each do |post_self|
      expect(michael.feed.include?(post_self)).to be true
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      expect(michael.feed.include?(post_unfollowed)).to be_falsey
    end
  end
end
