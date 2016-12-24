class NewsController < ApplicationController
  def index
    @posts = Post.where('created_at >= ?', 3.month.ago.utc).order("created_at DESC").all
  end

  def archive
    @years = [2014, 2015]
    m = %w(All January February March April May June July August September October November December)
    @year = params[:year].to_i
    @month = params[:month].to_i
    @months = []
    m.each do |f|
      @months.push([f, @months.length])
    end

    if @month == 0
      from = Time.utc(@year)
      to = Time.utc(@year + 1)
    else
      from = Time.utc(@year, @month)
      if @month < 12
        to = Time.utc(@year, @month + 1)
      else
        to = Time.utc(@year + 1)
      end
    end
    @posts = Post.where('created_at >= ? and created_at < ?', from, to).order("created_at DESC").all
  end

  def read
    @post = Post.find params[:id]
  end
end
