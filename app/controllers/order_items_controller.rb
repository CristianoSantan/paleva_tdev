class OrderItemsController < ApplicationController
  before_action :authenticated

  def new
    @order_item = OrderItem.new
    @menu_item = MenuItem.find(params[:menu_item_id])
    @portions = @menu_item.menuable.portions
    @menu = Menu.find(params[:menu_id])
  end
  
  def create
    session[:order_items] ||= []

    item = order_item_params

    session[:order_items] << item

    @menu = Menu.find(params[:order_item][:menu_id])
    redirect_to @menu
  end

  private 

  def order_item_params
    params.require(:order_item).permit(
      :orderable_id, 
      :portion_id, 
      :note, 
      :order_id
      )
  end
end