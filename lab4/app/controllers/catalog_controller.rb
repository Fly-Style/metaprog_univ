class CatalogController < ApplicationController
  def index
    @categories = Category.roots
    @cats_nav = cats_nav @categories
  end

  def category
    @categories = Category.roots
    @cats_nav = cats_nav @categories
    @category = Category.find params[:id]
    @products = Product.where(:category_id => params[:id]).paginate(:page => params[:page], :per_page => 6)
  end

  def product
    @product = Product.find params[:id]
  end

  def cats_nav cats
    s = '<ul>'
    cats.each do |cat|
       s += "<li><h4><a href='/catalog/category/#{cat.id}'>#{cat.name}</a></h4>"
       s += cats_nav(cat.children) + "</li>"
    end
    s += '</ul>'
  end

  def search
    @query = params[:q]

    if @query.to_s.empty?
      @products = []
    else
      @products = Product.where('(name LIKE :query OR desc_long LIKE :query)',query: "%#{@query}%")
                      .paginate(:page => params[:page], :per_page => 6)
    end
  end
end
