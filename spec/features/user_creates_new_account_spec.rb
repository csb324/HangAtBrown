require 'rails_helper'

feature 'User creates new account' do

  scenario 'successfully' do

    create(:location, name: "The Blue Room")
    visit root_path
    click_link "sign up"

    fill_in 'First name', with: 'Christina'
    fill_in 'Last name', with: 'Paxson'
    fill_in 'Email', with: 'cpax@brown.edu'
    fill_in 'Phone number', with: '401-867-5309'
    fill_in 'Class year', with: 'Faculty'
    fill_in 'Concentration', with: 'Math and shit'
    fill_in 'Password', with: 'ruthrocks'
    fill_in 'Password confirmation', with: 'ruthrocks'

    click_button 'Sign up'

    expect(page).to have_content "The Blue Room"

  end

end
