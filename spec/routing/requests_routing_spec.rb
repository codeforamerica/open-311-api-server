require "spec_helper"

describe RequestsController do
  describe "routing" do

    it "routes to #index" do
      get("/requests").should route_to("requests#index")
    end

    it "routes to #new" do
      get("/requests/new").should route_to("requests#new")
    end

    it "routes to #show" do
      get("/requests/1").should route_to("requests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/requests/1/edit").should route_to("requests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/requests").should route_to("requests#create")
    end

    it "routes to #update" do
      put("/requests/1").should route_to("requests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/requests/1").should route_to("requests#destroy", :id => "1")
    end

  end
end
