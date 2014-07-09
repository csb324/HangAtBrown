require 'rails_helper'

feature 'User views an individual hang' do
  scenario 'successfully' do
    carb = create(:user)
    ruth = create(:user, first_name: "Ruth")
    sign_in_as(carb)

    ratty = create(:location, name: "The Ratty")
    lunch = create(:event_with_host, location: ratty, user: ruth)

    visit root_path
    click_link "The Ratty"
    click_on "Ruth"

    expect(page).to have_content "Ruth"
    expect(page).to have_field :rsvp_expected_arrival
    expect(page).to have_button "join"
  end

  scenario 'and joins' do
    carb = create(:user)
    ruth = create(:user, first_name: "Ruth")
    sign_in_as(carb)

    ratty = create(:location, name: "The Ratty")
    lunch = create(:event_with_host, location: ratty, user: ruth)

    visit root_path
    click_link "The Ratty"
    click_on "Ruth"

    fill_in :rsvp_expected_arrival, with: lunch.start_time
    fill_in :rsvp_outfit, with: "Crazy socks"

    click_on "join"

    expect(page).to have_content "Awesome!"
    expect(page).to have_content "will be wearing"

  end

end
