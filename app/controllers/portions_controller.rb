class PortionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portion, only: [:edit, :update]
  before_action :set_dish_or_drink

  def new
    @portion = Portion.new
  end
  
  def create
    @portion = @dish_or_drink.portions.build(portion_params)
    @price_history = PriceHistory.new(portion: @portion, real: @portion.real, cent: @portion.cent, last_update: DateTime.now)
    @price_history.save

    if @portion.save
      redirect_to @dish_or_drink, notice: "Porção cadastrada com sucesso."
		else
			flash.now[:alert] = "Porção não cadastrada."
			render 'new'
		end
  end

  def edit; end
  
  def update
		if @portion.update(portion_params)
      @price_history = PriceHistory.new(portion: @portion, real: @portion.real, cent: @portion.cent, last_update: DateTime.now)
      @price_history.save
      
      redirect_to @dish_or_drink, notice: 'Porção editada com sucesso.'
      else
        flash.now[:alert] = 'Não foi possível atualizar o Porção'
        render 'edit'
      end
  end

  private

  def set_dish_or_drink
    @dish_or_drink = params[:drink_id].nil? ? Dish.find(params[:dish_id]) : Drink.find(params[:drink_id])
  end

  def set_portion
    @portion = Portion.find(params[:id])
  end

  def portion_params
    params.require(:portion).permit(:description, :real, :cent, :portionable)
  end
end