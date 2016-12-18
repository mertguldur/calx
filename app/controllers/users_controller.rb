class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    redirect_to root_path unless Integer(params[:id]) == current_user.id
    @user = User.find(params[:id])
  end

  def update
    redirect_to root_path unless Integer(params[:id]) == current_user.id
    @user = User.find(params[:id])
    if @user.authenticate(params[:current_password])
      if @user.update_attributes(user_update_params)
        flash.now[:success] = 'Changes saved successfully'
      end
    else
      @user.errors.add(:base, 'Invalid current password')
    end
    render 'show'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_update_params
    params.permit(:email, :password, :password_confirmation)
  end
end
