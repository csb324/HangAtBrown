require 'rails_helper'

feature 'User views one location' do
  scenario 'and all open events appear' do

    carb = create(:user, last_name: 'carberry')
    ruth = create(:user, first_name: 'Ruth')

    sign_in_as(carb)

    ratty = create(:location, name: "The Ratty")
    jos = create(:location, name: "Jo's")
    ev1 = create(:event, location: ratty, topic: "Burgers")
    ev1r = create(:rsvp, user: ruth, event: ev1, creator: true)

    visit root_path

    save_and_open_page

    click_link "The Ratty"

    expect(page).to have_content "Burgers"

  end
end
