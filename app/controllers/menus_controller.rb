class MenusController < ApplicationController
  before_action :authenticated, only: [:index, :show]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_menu_and_check_user, only: [:show]

  def index
    @menus = Menu.all
  end

  def show
    @menu_items = @menu.menu_items
    @dishes = @menu.dishes
    @drinks = @menu.drinks
  end
  
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

  def set_menu_and_check_user
    @menu = Menu.find(params[:id])
    if @menu.establishment.id != current_establishment.id
      return redirect_to root_path, alert: 'Você não possui acesso a essa bebida.'
    end
  end

  def menu_params
    params.require(:menu).permit(:name, :establishment_id)
  end
  
end