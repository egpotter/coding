require "rails_helper"

RSpec.describe ContractsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/customers/1/contracts").to route_to("contracts#index", customer_id: "1")
    end

    it "routes to #show" do
      expect(get: "/customers/1/contracts/2").to route_to("contracts#show", customer_id: "1", id: "2")
    end


    it "routes to #create" do
      expect(post: "/customers/1/contracts").to route_to("contracts#create", customer_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/customers/1/contracts/2").to route_to("contracts#update", customer_id: "1", id: "2")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/customers/1/contracts/2").to route_to("contracts#update", customer_id: "1", id: "2")
    end

    it "routes to #destroy" do
      expect(delete: "/customers/1/contracts/2").to route_to("contracts#destroy", customer_id: "1", id: "2")
    end
  end
end
