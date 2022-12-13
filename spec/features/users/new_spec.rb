# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Creating a new user' do
  describe 'As a visitor' do
    it 'I fill in the form with data and am redirected to users show page' do
      visit '/users/new'

      fill_in('Name:', with: 'Yuji')
      fill_in('Email:', with: 'yuji@yuji.com')
      fill_in("Password:", with: 'test')
      fill_in("Confirm Password:", with: 'test')

      click_button('Register')
      new_user = User.last
      expect(current_path).to eq("/users/#{new_user.id}")
    end

    it 'returns an error message if email is already taken' do
      @yuji = User.create!(name: 'Yuji', email: 'yuji@yuji.com', password: "test", password_confirmation: "test")
      visit '/users/new'

      fill_in('Name:', with: 'Yuji')
      fill_in('Email:', with: 'yuji@yuji.com')
      fill_in("Password:", with: 'test')
      fill_in("Confirm Password:", with: 'test')

      click_button('Register')
      
      expect(page).to have_content('Email has already been taken')
    end

    it 'returns an error message if name is left blank' do
      visit '/users/new'

      fill_in('Name', with: '')
      fill_in('Email:', with: 'yuji@yuji.com')
      fill_in("Password:", with: 'test')
      fill_in("Confirm Password:", with: 'test')

      click_button('Register')

      expect(page).to have_content("Error: Name can't be blank")
    end

    it 'returns an error message if password is left blank' do
      visit '/users/new'

      fill_in('Name:', with: 'Yuji')
      fill_in('Email:', with: 'yuji@yuji.com')
      fill_in("Password:", with: '')
      fill_in("Confirm Password:", with: 'test')

      click_button('Register')

      expect(page).to have_content("Error: Password can't be blank")
    end

    it 'returns an error message if password confirmation is blank or doesn not match password' do
      visit '/users/new'

      fill_in('Name:', with: 'Yuji')
      fill_in('Email:', with: 'yuji@yuji.com')
      fill_in("Password:", with: 'test')
      fill_in("Confirm Password:", with: '')

      click_button('Register')

      expect(page).to have_content("Error: Password confirmation doesn't match Password, Password confirmation can't be blank")
    end
  end
end
