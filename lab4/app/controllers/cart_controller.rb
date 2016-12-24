class CartController < ApplicationController
  def index
    unless session[:cart].blank?
      @products = []
      session[:cart].each do |pos|
        @products << Product.find(pos)
      end
    end
  end

  def checkout
  end

  def checkout_post
    unless session[:cart].blank?
      order = Order.new(checkout_params)
      order.save
      session[:cart].each do |pos|
        p = Product.find(pos)
        op = OrderPosition.new({product_id: p.id, price: p.price, order_id: order.id})
        op.save
      end
      session[:cart] = []
    end
  end

  def add
    if session[:cart].blank?
      session[:cart] = []
    end

    session[:cart] << params[:product_id]

    redirect_to "/cart"
  end


  private

  def checkout_params
    params.permit(:name, :email, :address, :comment)
  end
end
