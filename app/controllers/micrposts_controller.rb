class MicrpostsController < ApplicationController
  before_filter :authenticate
  
  def create
    @micrpost = current_user.micrposts.build(params[:micrpost])
    if @micrpost.save
      redirect_to root_path, :flash => { :success => "Micropost created!" }
    else
      render 'pages/home'
    end 
  end
  
  def destroy
  end
end