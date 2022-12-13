# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User discover page' do
  before :each do
    @mostafa = User.create!(name: 'Mostafa', email: 'sasa2020@hotmail.com', password: 'test',
                            password_confirmation: 'test')
    @jim = User.create!(name: 'Jimothy', email: 'jimmyboy@hotmail.com', password: 'test', password_confirmation: 'test')
    @bryan = User.create!(name: 'Bryan', email: 'breakingbad2020@hotmail.com', password: 'test',
                          password_confirmation: 'test')
  end

  describe 'As a visitor' do
    it 'When I visit user/:id/discover I see a button to discover top rated movies' do
      json_response = File.read('spec/fixtures/top_rated_movies.json')

      stub_request(:get, 'https://api.themoviedb.org/3/movie/top_rated?api_key=fcffd3018e92893c2d9bde84c969cedc')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Faraday v2.7.1'
          }
        )
        .to_return(status: 200, body: json_response, headers: {})

      visit "/users/#{@jim.id}/discover"

      expect(page).to have_button('Find Top Rated Movies')

      click_button 'Find Top Rated Movies'

      expect(current_path).to eq("/users/#{@jim.id}/movies")
    end
  end
end
