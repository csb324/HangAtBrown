require 'rails_helper'

feature 'User views locations' do
  scenario 'and they all appear' do

    carb = create(:user, last_name: 'carberry')
    ratty = create(:location, name: "The Ratty")
    jos = create(:location, name: "Jo's")

    sign_in_as(carb)

    visit root_path
    # save_and_open_page

    expect(page).to have_content "The Ratty"
    expect(page).to have_content "Jo's"

  end
end
