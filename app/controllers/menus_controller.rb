class MenusController < ApplicationController
  before_action :set_menu, only: [:show]

  def index
    @menus = Menu.all
    @establishment = current_user.establishment
  end

  def show; end
  
  def new
    @menu = Menu.new
  end
  
  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      redirect_to @menu, notice: 'Cardápio cadastrado com sucesso'
    else
      flash.now[:alert] = 'Cardápio não cadastrado'
      render 'new'
    end
  end

  private

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :establishment_id)
  end
  
end