require 'rails_helper'

feature 'User can create an event' do
  scenario 'successfully' do

    carb = create(:user, last_name: 'carberry')
    ratty = create(:location, name: "The Ratty")

    sign_in_as(carb)

    visit root_path

    click_link 'hang'

    select 'eat', from: 'What'
    select 'The Ratty', from: 'Where'
    select '10:00 PM', from: 'Start time'
    select '11:00 PM', from: 'End time'
    fill_in 'Topic', with: "Nudity"
    fill_in 'Outfit', with: "Silly hat"

    click_button 'hang'

    expect(page).to have_content "talk about nudity"
    expect(page).to have_no_content "Silly hat"
    expect(page).to have_content "Event saved"

  end
end
