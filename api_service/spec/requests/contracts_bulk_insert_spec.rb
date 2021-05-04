# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/contracts', type: :request do

  let!(:customer_1) do
    Customer.create(name: 'John doe', email: 'test@test.com', address: 'Fake address')
  end

  let!(:customer_2) do
    Customer.create(name: 'Jane doe', email: 'jane@test.com', address: 'Fake address')
  end

  let(:contracts) do
    [
      {
        price: 250.00,
        start_date: '2020-01-01',
        end_date: '2022-12-31',
        expiry_date: '2022-12-31',
        customer_id: customer_1.id.to_s,
      },
      {
        price: 500.00,
        start_date: '2020-01-01',
        end_date: '2022-12-31',
        expiry_date: '2022-12-31',
        customer_id: customer_1.id.to_s,
      }, {
        price: 1000.00,
        start_date: '2020-01-01',
        end_date: '2022-12-31',
        expiry_date: '2022-12-31',
        customer_id: customer_2.id.to_s,
      },
    ]
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates new contracts via delayed jobs' do
        expect do
          post '/contracts',
               params: { contracts: contracts }, as: :json
        end.to change(Delayed::Job, :count).by(3)

        expect do
          Delayed::Worker.new.work_off
        end.to change(Delayed::Job, :count).by(-3)
          .and change(Contract, :count).by(3)
      end
    end
  end
end
