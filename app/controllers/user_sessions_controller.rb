class UserSessionsController < ApplicationController

  include Encryptor

  def new
    @user = User.new
  end

  def create
    if @user = login(encrypt(params[:email]), params[:password])
      redirect_back_or_to(root_path, info: 'Login successful')
    else
      flash.now[:danger] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Logged out!'
  end
end
