require 'rails_helper'

include Helpers

describe "Beers" do
  before :each do
    FactoryGirl.create :beer
  end

  it "should add beer if beer name entered" do
    visit new_beer_path
    fill_in('beer_name', with: 'My new beer')

    expect {
      click_button("Create Beer")
    }.to change { Beer.count }.by(1)
  end

  it "should not add beer if beer has no name" do
    visit new_beer_path

    expect {
      click_button("Create Beer")
    }.to change { Beer.count }.by(0)

    expect(page).to have_content "Name can't be blank"
  end


end
