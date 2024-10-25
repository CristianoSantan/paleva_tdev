class DrinksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :new]
  before_action :set_drink, only: [:show, :edit, :update]

  def index
		@drinks = Drink.all
	end

  def show; end

	def new
		@drink = Drink.new()
		@establishment = Establishment.find_by(user_id: current_user.id)
	end

	def create
		@drink = Drink.new(drink_params)

		if @drink.save()
			redirect_to root_path, notice: "Bebida cadastrada com sucesso."
		else
			flash.now[:alert] = "Bebida não cadastrada."
			render 'new'
		end
	end

	def edit; end

	def update
		if @Drink.update(drink_params)
		redirect_to drink_path(@Drink.id), notice: 'Bebida atualizada com sucesso'
		else
			flash.now[:alert] = 'Não foi possível atualizar a Bebida'
			render 'edit'
		end
	end

	private

	def set_drink
		@drink = Drink.find(params[:id])
	end

	def drink_params
		params.require(:drink).permit(:name, :description, :alcoholic, :calories, :establishment_id)
	end
end