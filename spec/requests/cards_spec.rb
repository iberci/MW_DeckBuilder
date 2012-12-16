require 'spec_helper'

describe "Cards" do
  describe "GET /cards" do
    it "works" do
      get cards_path
      response.status.should be(200)
    end
  end

  describe "get filtered cards" do
    it "only returns cards with 'holy' school and type 'Attack'" do 
      get cards_path(:params => {:for_school => 'Holy', :for_type => 'Attack'})
      response.body.should include('Blinding Flash')
    end
  end
end
