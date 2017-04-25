class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate page: params[:page], per_page: Settings.per_page
    end
  end
end
