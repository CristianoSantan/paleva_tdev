class PreRegistrationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pre_registrations = current_user.establishment.pre_registrations
  end

  def new
    @pre_registration = current_user.establishment.pre_registrations.build
  end

  def create
    @pre_registration = current_user.establishment.pre_registrations.build(pre_registration_params)
    if @pre_registration.save
      redirect_to pre_registrations_path, notice: "Pré-cadastro criado com sucesso."
    else
      flash.now[:alert] = "Pré-cadastro não criado."
      render :new
    end
  end

  private

  def pre_registration_params
    params.require(:pre_registration).permit(:email, :cpf)
  end
end
