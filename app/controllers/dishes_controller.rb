class DishesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :new, :create]
  before_action :set_dish_and_check_user, only: [:show, :edit, :update, :disabled, :enabled]

  def index
		@dishes = current_account.establishment.dishes
	end

  def show
		@portions = @dish.portions
		@tags = @dish.tags
	end

	def new
		@dish = Dish.new()
		@dish.tags.build
		@tags = current_account.establishment.tags
	end

	def create
		@dish = Dish.new(dish_params)

		if @dish.save()
			redirect_to dishes_path, notice: "Prato cadastrado com sucesso."
		else
			flash.now[:alert] = "Prato não cadastrado."
			render 'new'
		end
	end

	def edit
		@dish.tags.build if @dish.tags.empty?
		@tags = current_account.establishment.tags
	end

	def update
		if @dish.update(dish_params)
			redirect_to @dish, notice: 'Prato atualizado com sucesso'
		else
			flash.now[:alert] = 'Não foi possível atualizar o Prato'
			render 'edit'
		end
	end

	def disabled
		@dish.disabled!
		redirect_to @dish
	end
	
	def enabled
		@dish.enabled!
		redirect_to @dish
	end

	private

	def set_dish_and_check_user
		@dish = Dish.find(params[:id])
		if @dish.establishment.id != current_establishment.id
				return redirect_to root_path, alert: 'Você não possui acesso a esse prato.'
		end
	end

	def dish_params
		params.require(:dish).permit(
			:image, 
			:name, 
			:description, 
			:calories, 
			:establishment_id, 
			tags_attributes: [:id, :establishment_id, :name, :_destroy])
	end
end