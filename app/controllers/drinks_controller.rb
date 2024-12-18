class DrinksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :new]
  before_action :set_drink_and_check_user, only: [:show, :edit, :update, :disabled, :enabled]

  def index
		@drinks = current_account.establishment.drinks
	end

  def show
		@portions = @drink.portions
	end

	def new
		@drink = Drink.new()
	end

	def create
		@drink = Drink.new(drink_params)

		if @drink.save()
			redirect_to drinks_path, notice: "Bebida cadastrada com sucesso."
		else
			flash.now[:alert] = "Bebida não cadastrada."
			render 'new'
		end
	end

	def edit;	end

	def update
		if @drink.update(drink_params)
		redirect_to drink_path(@drink.id), notice: 'Bebida atualizada com sucesso'
		else
			flash.now[:alert] = 'Não foi possível atualizar a Bebida'
			render 'edit'
		end
	end

	def disabled
		@drink.disabled!
		redirect_to @drink
	end
	
	def enabled
		@drink.enabled!
		redirect_to @drink
	end

	private

	def set_drink_and_check_user
		@drink = Drink.find(params[:id])
		if @drink.establishment.id != current_establishment.id
				return redirect_to root_path, alert: 'Você não possui acesso a essa bebida.'
		end
	end

	def drink_params
		params.require(:drink).permit(:image, :name, :description, :alcoholic, :calories, :establishment_id)
	end
end