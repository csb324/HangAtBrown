require 'rails_helper'

feature 'User views one location' do
  scenario 'and open events appear' do

    carb = create(:user, last_name: 'carberry')
    ruth = create(:user, first_name: 'Ruth')

    sign_in_as(carb)

    ratty = create(:location, name: "The Ratty")
    jos = create(:location, name: "Jo's")
    event_one = create(:event, location: ratty, topic: "Burgers")
    event_oner = create(:rsvp, user: ruth, event: event_one, creator: true)

    visit root_path

    click_link "The Ratty"

    expect(page).to have_content "Burgers"

  end

  scenario 'and events in the past do not appear' do

    carb = create(:user)
    ruth = create(:user, first_name: 'Ruth')
    ratty = create(:location, name: "The Ratty")
    sign_in_as(carb)

    event_two = create(:event, location: ratty, topic: "Physics", start_time: Time.now - 1.day, end_time: Time.now - 16.hours)
    event_two_rsvp = create(:rsvp, user: ruth, event: event_two, creator: true)

    event_one = create(:event, location: ratty, topic: "Burgers")
    event_one_rsvp = create(:rsvp, user: ruth, event: event_one, creator: true)

    visit root_path

    click_link "The Ratty"

    expect(page).to have_content "Burgers"
    expect(page).to have_no_content "Physics"

  end

end
