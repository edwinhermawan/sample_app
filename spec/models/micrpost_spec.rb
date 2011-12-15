require 'spec_helper'

describe Micrpost do
 before(:each) do
   @user = Factory(:user)
   @attr = {:content => "lorem ipsum"}
 end
 
 it "should create a new instance with valide attributes" do
   @user.micrposts.create!(@attr)
 end
 
 describe "user associations" do
   
   before(:each) do
     @micrpost = @user.micrposts.create(@attr)
   end
   it "should have a user attribute" do
     @micrpost.should respond_to(:user)
   end
   
   it "should have the rgiht associated user" do
     @micrpost.user_id.should == @user.id
     @micrpost.user.should == @user
   end
 end
 
 describe "validations" do
   it "should have a user id" do
     Micrpost.new(@attr).should_not be_valid
   end
   
   it "should require nonblank content" do
     @user.micrposts.build(:content => " ").should_not be_valid
   end
   
   it "should reject long content" do
     @user.micrposts.build(:content => "a" * 141).should_not be_valid
   end
 end
 
 describe "from_users_followed_by" do
   before(:each) do
     @other_user = Factory(:user, :email => Factory.next(:email))
     @third_user = Factory(:user, :email => Factory.next(:email))
     
     @user_post = @user.micrposts.create!(:content => "foo")
     @other_post = @other_user.micrposts.create!(:content => "bar")
     @third_post = @third_user.micrposts.create!(:content => "baz")
     
     @user.follow!(@other_user)
   end
   
   it "should hvae a from_users_followed_by method" do
     Micrpost.should respond_to(:from_users_followed_by)
   end
   
   it "should include teh followed user's micrposts" do
     Micrpost.from_users_followed_by(@user).
      should include(@other_post)
   end
   
   it "should include teh users's own micrposts" do
     Micrpost.from_users_followed_by(@user).
      should include(@user_post)
   end
   
   it "should not include an unfollowed users's micrposts" do
     Micrpost.from_users_followed_by(@user).
      should_not include(@third_post)
   end
 end
end

# == Schema Information
#
# Table name: micrposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

