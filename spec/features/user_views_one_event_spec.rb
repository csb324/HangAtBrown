require 'rails_helper'

feature 'User can view an individual hang' do

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
    expect(page).to have_content "join"

  end

end
