require "rails_helper"

RSpec.feature "Fleet calculator", :type => :feature do
	before(:all) do
		Ship.destroy_all
		Ship.create!(ship_name:"first", ship_capacity: "2")
  	Ship.create!(ship_name:"fifth", ship_capacity: "5")
  end

  scenario "User clicks the calculate button and goes to the results page" do
    visit "/fleet_calculator/show"

    fill_in "total_weight", :with => "13"
    click_button "Calculate"

    expect(page).to have_text("Fleet Composition for Total Cargo of 13 Tons")
  end

  scenario "Generates valid manifest for a given tonnage" do
	  visit "/fleet_calculator/show"

    fill_in "total_weight", :with => "7"
    click_button "Calculate"

    expect(page).to have_selector('table tr', text: /first 2 tons 1/)
    expect(page).to have_selector('table tr', text: /fifth 5 tons 1/)
  end


  scenario "Generates no manifest for an invalid tonnage" do
	  visit "/fleet_calculator/show"

    fill_in "total_weight", :with => "3"
    click_button "Calculate"
    expect(page).to have_text("No suitable fleet found")
  end


end