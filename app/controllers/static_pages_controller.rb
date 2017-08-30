class StaticPagesController < ApplicationController
  def home
    @skip_header = true
    @skip_footer = true
  end

  def help
  end
  
  def about
  end
end
