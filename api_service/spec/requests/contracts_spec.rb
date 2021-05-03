# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/customers/:customer_id/contracts', type: :request do
  let(:valid_attributes) do
    {
      price: 250.00,
      start_date: '2020-01-01',
      end_date: '2022-12-31',
      expiry_date: '2022-12-31'
    }
  end
  let(:invalid_attributes) do
    {
      start_date: 'invalid'
    }
  end

  let!(:customer) do
    Customer.create(name: 'John doe', email: 'test@test.com', address: 'Fake address')
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get customer_contracts_url(customer_id: customer.id), as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      contract = customer.contracts.create!(valid_attributes)
      get customer_contract_url(contract, customer_id: customer.id), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Contract' do
        expect do
          post customer_contracts_url(customer_id: customer.id),
               params: { contract: valid_attributes }, as: :json
        end.to change(Contract, :count).by(1)
      end

      it 'renders a JSON response with the new contract' do
        post customer_contracts_url(customer_id: customer.id),
             params: { contract: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(
          a_string_including('application/json; charset=utf-8')
        )
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Contract' do
        expect do
          post customer_contracts_url(customer_id: customer.id),
               params: { contract: invalid_attributes }, as: :json
        end.to change(Contract, :count).by(0)
      end

      it 'renders a JSON response with errors for the new contract' do
        post customer_contracts_url(customer_id: customer.id),
             params: { contract: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          price: 250_000.00,
          start_date: '2020-05-05',
          end_date: '2030-05-05',
          expiry_date: '2040-05-05'
        }
      end

      it 'updates the requested contract' do
        contract = customer.contracts.create!(valid_attributes)
        patch customer_contract_url(contract, customer_id: customer.id),
              params: { contract: new_attributes }, as: :json
        contract.reload
        expect(contract.price).to eq(250_000)
        expect(contract.start_date).to eq(Date.new(2020, 0o5, 0o5))
        expect(contract.end_date).to eq(Date.new(2030, 0o5, 0o5))
        expect(contract.expiry_date).to eq(Date.new(2040, 0o5, 0o5))
      end

      it 'renders a JSON response with the contract' do
        contract = customer.contracts.create!(valid_attributes)
        patch customer_contract_url(contract, customer_id: customer.id),
              params: { contract: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(
          a_string_including('application/json; charset=utf-8')
        )
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the contract' do
        contract = customer.contracts.create!(valid_attributes)

        patch customer_contract_url(contract, customer_id: customer.id),
              params: { contract: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested contract' do
      contract = customer.contracts.create!(valid_attributes)
      expect do
        delete customer_contract_url(contract, customer_id: customer.id), as: :json
      end.to change(Contract, :count).by(-1)
    end
  end
end
