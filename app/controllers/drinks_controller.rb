class DrinksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :new]
  before_action :set_drink_and_check_user, only: [:show, :edit, :update]

  def index
		@drinks = current_user.establishment.drinks
	end

  def show; end

	def new
		@drink = Drink.new()
		@establishment = current_user.establishment
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

	def edit
		@establishment = current_user.establishment
	end

	def update
		if @drink.update(drink_params)
		redirect_to drink_path(@drink.id), notice: 'Bebida atualizada com sucesso'
		else
			flash.now[:alert] = 'Não foi possível atualizar a Bebida'
			render 'edit'
		end
	end

	private

	# def set_drink
	# 	@drink = Drink.find(params[:id])
	# end

	def set_drink_and_check_user
		@drink = Drink.find(params[:id])
		if @drink.establishment.user != current_user
				return redirect_to root_path, alert: 'Você não possui acesso a essa bebida.'
		end
	end

	def drink_params
		params.require(:drink).permit(:image, :name, :description, :alcoholic, :calories, :establishment_id)
	end
end