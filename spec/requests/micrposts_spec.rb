require 'spec_helper'

describe "Micrposts" do
  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
  end
  
  describe "creation" do
    describe "failure" do
      it "shoudl not make a new micrpost" do
        lambda do
          visit root_path
          fill_in :micrpost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector('div#error_explanation')
        end.should_not change(Micrpost, :count)
      end
    end
    
    describe "success" do
      it "shoudl make a new micrpost" do
        content = "Lorem ipsum"
        lambda do
          visit root_path
          fill_in :micrpost_content, :with => content
          click_button
          response.should have_selector('span.content', :content => content)
        end.should change(Micrpost, :count).by(1)
      end
    end
  end
end
