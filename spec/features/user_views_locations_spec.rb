require 'rails_helper'

feature 'User views locations' do
  scenario 'and they all appear' do

    carb = create(:user, last_name: 'carburry')
    sign_in_as(carb)

    visit root_path

    expect(page).to have_content "The Ratty"

  end
end
