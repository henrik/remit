class UsersBaseController < ApplicationController
  private

  def authorization
    UserAuthorization.new(params[:auth_key], session)
  end
end
