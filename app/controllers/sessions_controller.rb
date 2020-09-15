class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:success] = 'ログインしました。'
      redirect_to root_path(@today)
    else
      flash.now[:alert] = 'メールアドレスもしくはパスワードが正しくありません。'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to login_path
  end
end