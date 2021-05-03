require 'rails_helper'

RSpec.describe "/customers", type: :request do
  let(:valid_attributes) {
    {
      name: 'John Doe',
      email: 'john@doe.com',
      address: '2nd Street, NY'
    }
  }

  let(:invalid_attributes) {
    {
      name: 'John Doe',
      email: 'Invalid email',
      address: '2nd Street, NY'
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Customer.create! valid_attributes
      get customers_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      customer = Customer.create! valid_attributes
      get customer_url(customer), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Customer" do
        expect {
          post customers_url,
               params: { customer: valid_attributes }, as: :json
        }.to change(Customer, :count).by(1)
      end

      it "renders a JSON response with the new customer" do
        post customers_url,
             params: { customer: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Customer" do
        expect {
          post customers_url,
               params: { customer: invalid_attributes }, as: :json
        }.to change(Customer, :count).by(0)
      end

      it "renders a JSON response with errors for the new customer" do
        post customers_url,
             params: { customer: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: 'A new name',
          email: 'new@email.com',

        }
      }

      it "updates the requested customer" do
        customer = Customer.create! valid_attributes
        patch customer_url(customer),
              params: { customer: new_attributes }, as: :json
        customer.reload

      end

      it "renders a JSON response with the customer" do
        customer = Customer.create! valid_attributes
        patch customer_url(customer),
              params: { customer: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the customer" do
        customer = Customer.create! valid_attributes
        patch customer_url(customer),
              params: { customer: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested customer" do
      customer = Customer.create! valid_attributes
      expect {
        delete customer_url(customer), as: :json
      }.to change(Customer, :count).by(-1)
    end
  end
end
