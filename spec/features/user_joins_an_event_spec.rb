require 'rails_helper'

feature 'User views an individual hang' do
  scenario 'successfully' do
    carb = create(:user)
    ruth = create(:user, first_name: "Ruth", last_name: "Simmons")
    sign_in_as(carb)

    ratty = create(:location, name: "The Ratty")
    lunch = create(:event_with_host, location: ratty, user: ruth)

    visit root_path
    click_link "The Ratty"
    click_on "R.S."

    expect(page).to have_content "R.S."
    expect(page).to have_field :rsvp_expected_arrival
    expect(page).to have_button "join"
  end

  scenario 'and joins' do
    carb = create(:user)
    ruth = create(:user, first_name: "Ruth", last_name: "Simmons")
    sign_in_as(carb)

    ratty = create(:location, name: "The Ratty")
    lunch = create(:event_with_host, location: ratty, user: ruth)

    myarrival = lunch.start_time + 10.minutes

    visit root_path
    click_link "The Ratty"
    click_on "R.S."

    fill_in :rsvp_expected_arrival, with: myarrival
    fill_in :rsvp_outfit, with: "Crazy socks"

    click_on "join"

    expect(page).to have_content "Awesome!"
    expect(page).to have_content "will be wearing"
  end
end
