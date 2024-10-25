class DishesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :new, :create]
  before_action :set_dish, only: [:show, :edit, :update]

  def index
		@dishes = Dish.all
	end

  def show; end

	def new
		@dish = Dish.new()
		@establishment = Establishment.find_by(user_id: current_user.id)
	end

	def create
		@dish = Dish.new(dish_params)

		if @dish.save()
			redirect_to dishes_path, notice: "Prato cadastrado com sucesso."
		else
			flash.now[:notice] = "Prato não cadastrado."
			render 'new'
		end
	end

	def edit; end

	def update
		if @dish.update(dish_params)
		redirect_to dish_path(@dish.id), notice: 'Prato atualizado com sucesso'
		else
			flash.now[:notice] = 'Não foi possível atualizar o Prato'
			render 'edit'
		end
	end

	# def destroy
	# 	@dish.destroy
	# 	redirect_to root_path, notice: 'Prato removido com sucesso'
	# end

	private

	def set_dish
		@dish = Dish.find(params[:id])
	end

	def dish_params
		params.require(:dish).permit(:name, :description, :calories, :establishment_id)
	end
end