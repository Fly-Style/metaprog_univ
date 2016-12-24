class SiteController < ApplicationController
  def index
    @review = Review.new
    unless @user.nil?
      @review.name = @user.name
      @review.email = @user.email
    end

    @posts = Post.where('created_at >= ?', 1.month.ago.utc).order("created_at DESC").all

    @categories = Category.roots
  end

  def about
    @review = Review.new
    unless @user.nil?
      @review.name = @user.name
      @review.email = @user.email
    end
  end


  def loginForm
    unless session[:user_id].blank?
      redirect_to '/'
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user.nil? || !@user.authentificate(params)
      redirect_to '/login'
    else
      session[:user_id] = @user.id
      redirect_to '/'
    end
  end

  def logout
    reset_session
    # session.delete(:user_id)
    redirect_to '/login'
  end

end
