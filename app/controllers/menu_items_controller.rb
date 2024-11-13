class MenuItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def new
    @menu_item = MenuItem.new
    @menu = Menu.find(params[:menu_id])
    @item = params[:item]
    @dishes = @menu.establishment.dishes
    @drinks = @menu.establishment.drinks
  end

  def create
    @menu = Menu.find(params[:menu_id])
    @menuable = ''
    
    if @item == 'drink'
      @menuable = Drink.find(params[:menu_item][:menuable_id])
    else
      @menuable = Dish.find(params[:menu_item][:menuable_id])
    end
    
    @menu_item = MenuItem.new(menu: @menu, menuable: @menuable)
    
    if @menu_item.save
      redirect_to @menu, notice: "Item adicionado ao menu com sucesso."
    else
      flash.now[:alert] = "Item não adicionado."
      render 'new'
    end
  end

  private
  
  def menu_item_params
    params.require(:menu_item).permit(:menu_id, :menuable_id)
  end
end