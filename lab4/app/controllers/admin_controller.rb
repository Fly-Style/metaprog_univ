class AdminController < ApplicationController
  def index
    if @user.role != User::ROLE_ADMIN
      redirect_to '/'
    end
  end
end
