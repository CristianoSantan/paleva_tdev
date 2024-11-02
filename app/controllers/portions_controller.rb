class PortionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portion_and_check_user, only: [:edit, :update]

  def new
    @dish = Dish.find(params[:dish_id])
    @portion = Portion.new
  end
  
  def create
    @dish = Dish.find(params[:dish_id])
    
    if @dish.portions.create(portion_params)
      redirect_to @dish, notice: "Porção cadastrada com sucesso."
		else
			flash.now[:alert] = "Porção não cadastrada."
			render 'new'
		end
  end

  def edit
    @dish = Dish.find(params[:dish_id])
  end
  
  def update
    @dish = Dish.find(params[:dish_id])
		if @portion.update(portion_params)
      redirect_to @dish, notice: 'Porção editada com sucesso.'
      else
        flash.now[:alert] = 'Não foi possível atualizar o Porção'
        render 'edit'
      end
  end

  private

  def set_portion_and_check_user
    @portion = Portion.find(params[:id])
  end

  def portion_params
    params.require(:portion).permit(:description, :real, :cent, :portionable)
  end
end