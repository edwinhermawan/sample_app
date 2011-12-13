class MicrpostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy
  
  def create
    @micrpost = current_user.micrposts.build(params[:micrpost])
    if @micrpost.save
      redirect_to root_path, :flash => { :success => "Micropost created!" }
    else
      render 'pages/home' 
      @feed_items = [ ]
    end 
  end
  
  def destroy
    @micrpost.destroy
    redirect_to root_path
  end
  
  private
    def authorized_user
      @micrpost = Micrpost.find(params[:id])
      redirect_to root_path unless current_user?(@micrpost.user)
    end
end