class UsersController < ApplicationController
  def index
    @users = User.ransack(search_query).result.page(params[:page]).per(20)
    render json: @users
  end

  private
  def search_query
    params.permit(:status_eq, :screen_name_cont, :department_id_eq, :office_id_eq)
  end
end
