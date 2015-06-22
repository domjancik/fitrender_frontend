class VisitorsController < ApplicationController
  def index
    redirect_to scenes_url if user_signed_in?
  end
end
