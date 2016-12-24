class ProfileController < ApplicationController
  def index
    @history = []
    Order.where(name: @user.name).find_each do |h|
      p h.name;
      @history.push(h);
    end
  end

  def update
  end

  def updateForm
  end
end
