require 'rails_helper'

RSpec.describe 'As a user on my dashboard' do
  describe 'when I click on New trip' do
    it 'I can see a form to make a new trip' do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      file = File.read('spec/fixtures/response.json')
      stub_request(:get, 'http://localhost:9292/events?genres=indian,mexican,italian,music,sports')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v1.0.1'
          }
      ).to_return(status: 200, body: file, headers: {})

      visit '/user'

      click_on 'New Trip'

      expect(page).to have_content('Trip Preferences')
      fill_in 'location', with: 'Denver, co'
      fill_in 'start_date', with: '2525/01/01'
      fill_in 'end_date', with: '2525/12/12'
      within '.cuisine_options' do
        check 'indian'
        check 'mexican'
        check 'italian'
      end
      within '.attraction_options' do
        check 'music'
        check 'sports'
      end
      click_on 'Create My Trip'

      expect(current_path).to eq(edit_user_trip_path(Trip.first))

      # within('.trip_events") do
      #   expect(page'.to have_conten'('india'')
      #   expect(page).to have_content('mexican')
      #   expect(page).to have_content('italian')
      #   expect(page).to have_content('music')
      #   expect(page).to have_content('sports')
      #   expect(page).not_to have_content('french')
      #   expect(page).not_to have_content('tacos')
      #   expect(page).not_to have_content('pool parties')
      # end
    end
  end
end
