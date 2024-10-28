class HoursOperationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hour_and_check_user, only: [:edit, :update]

  def new
    @hours_operation = HoursOperation.new
  end

  def create
    @hours_operation = HoursOperation.new(hours_operation_params)
    
		if @hours_operation.save()
			redirect_to establishment_path(current_user.establishment.id), notice: "Horário cadastrado com sucesso."
		else
			flash.now[:alert] = "Horário não cadastrado."
			render 'new'
		end
  end

  def edit;	end

  def update
		if @hours_operation.update(hours_operation_params)
		redirect_to establishment_path(current_user.establishment.id), notice: 'horário atualizado com sucesso'
		else
			flash.now[:alert] = 'Não foi possível atualizar a horário'
			render 'edit'
		end
	end

  private

  def set_hour_and_check_user
		@hours_operation = HoursOperation.find(params[:id])
		if @hours_operation.establishment.user != current_user
				return redirect_to root_path, alert: 'Você não possui acesso a esse horário.'
		end
	end

  def hours_operation_params
		params.require(:hours_operation).permit(:weekday, :opening_time, :closing_time, :closed, :establishment_id).tap do |param|
      param[:weekday] = param[:weekday].to_i if param[:weekday].present?
    end
	end
end