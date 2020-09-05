class UsersController < ApplicationController
  before_action :load_user, only: %i[show edit update]
  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, except: [:show]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_current_user
    @user = current_user
  end
end
