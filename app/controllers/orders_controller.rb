class OrdersController < ApplicationController
  before_action :authenticated

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @order_items = session[:order_items]

    @total = 0
    session[:order_items].each do |item|
      menu_item = MenuItem.find(item["orderable_id"]).menuable
      portion = Portion.find(item["portion_id"])

      @order.order_items.build(
        orderable: menu_item,
        portion: portion,
        note: item["note"]
      )
      @total += portion.real.to_f + portion.cent.to_f / 100
    end
    @total = format('%.2f', @total)
  end
  
  def create
    @order = Order.new(order_params)

    session[:order_items].each do |item|
      @order.order_items.build(
        orderable: MenuItem.find(item["orderable_id"]).menuable,
        portion: Portion.find(item["portion_id"]),
        note: item["note"]
      )
    end

    if @order.save
      session[:order_items] = []
      redirect_to order_path(@order), notice: "Pedido criado com sucesso!"
    else
      @order_items = session[:order_items]
      flash.now[:alert] = "Pedido não criado."
      render 'new'
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :name, 
      :phone, 
      :email, 
      :cpf, 
      :code, 
      :status, 
      :establishment_id,
      order_items_attributes: [
        :id, 
        :order_id, 
        :orderable_id, 
        :orderable, 
        :portion_id, 
        :portion, 
        :note, 
        :_destroy
      ]
    )
  end
  
end