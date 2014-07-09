require 'rails_helper'

feature 'User updates account' do
  scenario 'successfully' do

    carb = create(:user)
    sign_in_as(carb)

    visit root_path
    click_link carb.first_name
    click_link "edit"

    fill_in 'user_interest_one', with: 'chicken'
    fill_in 'user_interest_two', with: 'cheese'
    fill_in 'user_interest_three', with: 'spicy'

    fill_in 'Class year', with: 'Senior'
    fill_in 'Phone number', with: '4448885555'
    fill_in 'Current password', with: carb.password

    click_on "Update"

    expect(page).to have_content "chicken"
    expect(page).to have_content "successfully"

  end
end
