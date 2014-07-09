require 'rails_helper'

feature 'User can create an event' do
  scenario 'successfully' do

    carb = create(:user, last_name: 'carberry')
    ratty = create(:location, name: "The Ratty")
    sign_in_as(carb)

    visit root_path
    click_link 'hang'

    select 'eat', from: 'What'
    select 'The Ratty', from: 'event_location_id'
    fill_in 'event_start_time', with: "11:45 pm"
    fill_in 'event_end_time', with: "11:59 pm"
    fill_in 'Topic', with: "things to divest"
    fill_in 'Outfit', with: "Silly hat"

    click_button 'hang'

    expect(page).to have_content "talk about things to divest"
    expect(page).to have_no_content "Silly hat"
    expect(page).to have_content "Event saved"
  end

  scenario "unsuccessfully, because the time is in the past" do
    carb = create(:user, last_name: 'carberry')
    ratty = create(:location, name: "The Ratty")
    sign_in_as(carb)
    visit root_path
    click_link 'hang'

    select 'eat', from: 'What'
    select 'The Ratty', from: 'event_location_id'
    fill_in 'event_start_time', with: "7:00 am"
    fill_in 'event_end_time', with: "8:00 am"
    fill_in 'Topic', with: "Balloons"
    fill_in 'Outfit', with: "Silly hat"

    click_button 'hang'

    expect(page).to have_content "can't be in the past"
    expect(page).to have_no_content "balloons"
  end

  scenario "unsuccessfully, because event ends before it begins" do
    carb = create(:user, last_name: 'carberry')
    ratty = create(:location, name: "The Ratty")
    sign_in_as(carb)
    visit root_path
    click_link 'hang'

    select 'eat', from: 'What'
    select 'The Ratty', from: 'event_location_id'
    fill_in 'event_start_time', with: "7:00 pm"
    fill_in 'event_end_time', with: "8:00 am"
    fill_in 'Topic', with: "Insane nighttime activities"
    fill_in 'Outfit', with: "Silly hat"

    click_button 'hang'

    expect(page).to have_content "can't be before"
    expect(page).to have_no_content "balloons"

  end
end
