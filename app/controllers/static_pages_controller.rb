class StaticPagesController < ApplicationController
  def home
#      require 'nokogiri'
#      require 'open-uri'
#          # スクレイピング先のURL
#      doc = Nokogiri::HTML(open('http://weather.asahi.com'))
#      @objects = doc.xpath('//td/img/@alt')
      
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end
