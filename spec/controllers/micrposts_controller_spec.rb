require 'spec_helper'

describe MicrpostsController do
  render_views
  
  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST create" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      before(:each) do
        @attr = { :content => "" }
      end
      
      it "should not create a micropost" do
        lambda do
          post :create, :micrpost => @attr
        end.should_not change(Micrpost, :count)
      end
      
      it "should re-render the home page" do
        post :create, :micrpost => @attr
        response.should render_template('pages/home')
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = {:content => "Lorem ipsum dolar sit amet"}
      end
      
      it "should create a micrpost" do
        lambda do
          post :create, :micrpost => @attr
        end.should change(Micrpost, :count).by(1)
      end
      
      it "should redirect to the root path" do
        post :create, :micrpost => @attr
        response.should redirect_to(root_path)
      end
      
      it "should have a flash success message" do
        post :create, :micrpost => @attr
        flash[:success].should =~ /micropost created/i
      end
    end
  end
  
  describe "Delete 'destroy'" do
    describe "for an unauthorized user" do
      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        @micrpost = Factory(:micrpost, :user => @user)
        test_sign_in(wrong_user)
      end
      
      it "should deny access" do
        delete :destroy, :id => @micrpost
        response.should redirect_to(root_path)
      end
    end
    describe "for an authroized user" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @micrpost = Factory(:micrpost, :user => @user)
      end
      
      it "shoudl destroy the micrpost" do
        lambda do
          delete :destroy, :id => @micrpost
          response.should redirect_to(root_path)
        end.should change(Micrpost, :count).by(-1)
      end
      
    end
  end
end
