require 'rails_helper'

RSpec.describe "ship controller", :type => :request do

  it "creates a ship and redirects to ship's page" do
    get "/ships/new"
    expect(response).to render_template(:new)

    post "/ships", params:{:ship => {ship_name: "ship", ship_capacity: "1"}}
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Ship was successfully created.")
  end

  it "renders the index" do
    get "/ships"
    expect(response).to render_template(:index)
  end

  it "deletes a ship and redirects to the index page" do
    ship = Ship.create!(ship_name:"test",ship_capacity:1)

    delete "/ships/#{ship.id.to_s}"
    follow_redirect!

    expect(response).to render_template(:index)
    expect(response.body).to include("Ship was successfully destroyed.")
  end


end