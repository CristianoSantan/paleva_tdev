class EstablishmentsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :new]
  before_action :set_establishment_and_check_user, only: [:show, :edit, :update]

  # def index; end

  def show; end

	def search
    @dish_or_drink = params["query"]
		query = "name LIKE ? OR description LIKE ?"
    @drinks = current_user.establishment.drinks.where(query, "%#{@dish_or_drink}%", "%#{@dish_or_drink}%")
    @dishes = current_user.establishment.dishes.where(query, "%#{@dish_or_drink}%", "%#{@dish_or_drink}%")
  end

	def new
		@establishment = Establishment.new()
		@user = User.find(current_user.id)
	end

	def create
		@establishment = Establishment.new(establishment_params)

		if @establishment.save()
			redirect_to root_path, notice: "Estabelecimento cadastrado com sucesso."
		else
			flash.now[:notice] = "Estabelecimento não cadastrado."
			render 'new'
		end
		
	end

	def edit; end

	def update
		if @establishment.update(establishment_params)
		redirect_to establishment_path(@establishment.id), notice: 'Estabelecimento atualizado com sucesso'
		else
			flash.now[:notice] = 'Não foi possível atualizar o Estabelecimento'
			render 'edit'
		end
	end

	# def destroy
	# 	@establishment.destroy
	# 	redirect_to root_path, notice: 'Estabelecimento removido com sucesso'
	# end

	private

	def set_establishment_and_check_user
		@establishment = Establishment.find(params[:id])
		if @establishment.user != current_user
			return redirect_to root_path, alert: 'Você não possui acesso a esse estabelecimento.'
		end
	end

	def establishment_params
		params.require(:establishment).permit(:brand_name, :company_name, :cnpj, :phone, :full_address,
			:email, :code, :user_id)
	end
  
end