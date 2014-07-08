class RegistrationsController < Devise::RegistrationsController

  def after_sign_in_path_for(resource)
    profile_path
  end

  def after_update_path_for(resource)
    profile_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone_number, :concentration, :class_year, :interest_one, :interest_two, :interest_three)
  end

  def account_update_params
    params.require(:user).permit(:interest_one, :interest_two, :interest_three, :class_year, :concentration, :phone_number, :password, :password_confirmation, :current_password)
  end

end
