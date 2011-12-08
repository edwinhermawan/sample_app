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
