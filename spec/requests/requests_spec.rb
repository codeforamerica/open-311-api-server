require 'spec_helper'
require 'pry'

describe "Requests" do
  describe "GET /requests" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get requests_path
      response.status.should be(200)
    end
    it "should work with an ID" do
      get requests_path, id: 42
#      binding.pry
    end
  end
end
