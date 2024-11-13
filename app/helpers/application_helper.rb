module ApplicationHelper
  def current_account 
    user_signed_in? ? current_user : current_employee
  end

  def current_establishment 
    user_signed_in? ? current_user.establishment : current_employee.establishment
  end

end
