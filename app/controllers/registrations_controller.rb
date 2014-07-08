class RegistrationsController < Devise::RegistrationsController

  def after_sign_in_path_for(resource)
    profile_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone_number, :concentration, :class_year, :interest_one, :interest_two, :interest_three)
  end
end
