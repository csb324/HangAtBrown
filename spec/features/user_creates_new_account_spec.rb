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
    select 'Faculty', from: 'Class year'
    fill_in 'Concentration', with: 'Math and shit'
    fill_in 'Password', with: 'ruthrocks'
    fill_in 'Password confirmation', with: 'ruthrocks'
    fill_in 'user_interest_one', with: 'Poodles'
    fill_in 'user_interest_two', with: 'Coal'
    fill_in 'user_interest_three', with: 'Sunshine'

    click_button 'Sign up'

    expect(page).to have_content "Christina Paxson"
    expect(page).to have_content "coal"
    expect(page).to have_content "sunshine"

  end

  scenario 'unsuccessfully' do
    visit root_path
    click_link "sign up"
    fill_in 'First name', with: 'Butt'

    click_button 'Sign up'

    expect(page).to have_content "prohibited this user from being saved"

  end

end
