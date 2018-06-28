class SiteController < ApplicationController
  def index
    @members = Member.all
  end
end
