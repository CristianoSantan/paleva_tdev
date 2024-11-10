class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :require_establishment, except: [:new, :create],  unless: :devise_controller?
  
  protected

  def after_sign_in_path_for(resource)
    menus_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf])
  end

  def require_establishment
    if user_signed_in? && current_user.establishment.nil?
      redirect_to new_establishment_path, alert: "Por favor, cadastre seu estabelecimento antes de continuar."
    end
  end
end
