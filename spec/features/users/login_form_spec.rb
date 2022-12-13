# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User login form' do
  it 'can log in with valid credentials' do
    yuji = User.create!(name: 'Yuji', email: 'yuji@yuji.com', password: 'test', password_confirmation: 'test')

    visit '/'

    click_link 'Log in'

    expect(current_path).to eql('/login')

    fill_in('Email:', with: 'yuji@yuji.com')
    fill_in('Password:', with: 'test')

    click_on 'Log in'

    expect(current_path).to eql('/')

    expect(page).to have_content('Welcome, Yuji!')
  end

  it 'can not log in with invalid credentials' do
    yuji = User.create!(name: 'Yuji', email: 'yuji@yuji.com', password: 'test', password_confirmation: 'test')

    visit '/'

    click_link 'Log in'

    expect(current_path).to eql('/login')

    fill_in('Email:', with: 'yuji@yuji.com')
    fill_in('Password:', with: 'test123')

    click_on 'Log in'

    expect(current_path).to eql('/login')

    expect(page).to have_content('Sorry, your credentials are bad.')
  end
end
