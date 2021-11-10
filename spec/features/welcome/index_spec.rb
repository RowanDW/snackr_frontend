require 'rails_helper'

RSpec.describe 'Welcome Index' do
  it 'has the app name and a google login button' do
    visit root_path
    expect(page).to have_content("Snackr")
    expect(page).to have_button("Log in with Google")
  end
end
