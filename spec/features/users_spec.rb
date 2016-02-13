require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')

      expect {
        click_button('Create User')
      }.to change { User.count }.by(1)
    end


  end

  describe "User's ratings" do
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
    let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
    let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }

    let!(:user2) { FactoryGirl.create :user, username: "Jukka" }
    let!(:user3) { FactoryGirl.create :user, username: "Jaana" }
    let!(:rating) { FactoryGirl.create :rating, user: user3, beer: beer1, score: 10 }
    let!(:rating2) { FactoryGirl.create :rating, user: user3, beer: beer2, score: 20 }

    before :each do

    end


    it "displays ratings correctly on users page when there are no ratings" do
      sign_in(username: "Jukka", password: "Foobar1")
      visit user_path(user2)
      expect(page).to have_content "Has made 0 ratings"
    end

    it "displays ratings correctly on users page when there are two ratings" do
      sign_in(username: "Jaana", password: "Foobar1")
      visit user_path(user3)
      expect(page).to have_content "Has made 2 ratings"
      expect(page).to have_content "iso 3 10"
      expect(page).to have_content "Karhu 20"
    end

    it "removes rating from database when user wants to remove rating" do
      sign_in(username: "Jaana", password: "Foobar1")
      visit user_path(user3)
      expect(Rating.all.count).to eq(2)
      page.all('a', :text => 'delete')[1].click
      expect(page).to have_content "Has made 1 rating"
      expect(Rating.all.count).to eq(1)

    end


  end
end
