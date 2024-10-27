class DishesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :new, :create]
  before_action :set_dish_and_check_user, only: [:show, :edit, :update]

  def index
		@dishes = current_user.establishment.dishes
	end

  def show; end

	def new
		@dish = Dish.new()
		@establishment = current_user.establishment
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
		@establishment = current_user.establishment
	end

	def update
		if @dish.update(dish_params)
		redirect_to dish_path(@dish.id), notice: 'Prato atualizado com sucesso'
		else
			flash.now[:alert] = 'Não foi possível atualizar o Prato'
			render 'edit'
		end
	end

	# def destroy
	# 	@dish.destroy
	# 	redirect_to root_path, notice: 'Prato removido com sucesso'
	# end

	private

	# def set_dish
	# 	@dish = Dish.find(params[:id])
	# end

	def set_dish_and_check_user
		@dish = Dish.find(params[:id])
		if @dish.establishment.user != current_user
				return redirect_to root_path, alert: 'Você não possui acesso a esse prato.'
		end
	end

	def dish_params
		params.require(:dish).permit(:image, :name, :description, :calories, :establishment_id)
	end
end