require 'spec_helper'

describe "Cards" do
  describe "GET /cards" do
    it "works" do
      get cards_path
      response.status.should be(200)
    end
  end

  describe "get cards with school filter" do
    it "only returns cards with 'holy' school" 
      get cards_path(:params => {:for_school => 'Holy'})
      response.body.should include('holy')
    end
  end
end
