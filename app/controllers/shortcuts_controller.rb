class ShortcutsController < ApplicationController
  before_action :logged_in_user

  def index
    @shortcuts = Shortcut.where(user_id: current_user.id)
  end

  def new
    @shortcut = Shortcut.new
  end

  def create
    @shortcut = current_user.shortcuts.build(shortcut_params)
    if @shortcut.save
      flash[:success] = 'ショートカットを作成しました'
      redirect_to shortcuts_path
    else
      render action: 'new'
    end
  end

  def show
    redirect_to edit_shortcut_path
  end

  def edit
    @shortcut = Shortcut.find(params[:id])
  end

  def update
    @shortcut = Shortcut.find(params[:id])
    @shortcut.assign_attributes(shortcut_params)
    if @shortcut.save
      flash[:success] = 'ショートカットを更新しました'
      redirect_to shortcuts_path
    else
      render action: 'edit'
    end
  end

  def destroy
    @shortcut = Shortcut.find(params[:id])
    @shortcut.destroy
    flash[:success] = 'ショートカットを削除しました。'
    redirect_to shortcuts_path
  end

  private def shortcut_params
    params.require(:shortcut).permit(:title, :body)
  end
end