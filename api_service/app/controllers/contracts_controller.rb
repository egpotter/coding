# frozen_string_literal: true

class ContractsController < ApplicationController
  before_action :set_customer, except: %i[bulk_create]
  before_action :set_contract, only: %i[show update destroy]

  # GET /customers/1/contracts
  def index
    @contracts = @customer.contracts.all

    render json: @contracts
  end

  # GET /customers/1/contracts/2
  def show
    render json: @contract
  end

  # POST /customers/1/contracts
  def create
    @contract = @customer.contracts.new(contract_params)

    if @contract.save
      render json: @contract, status: :created,
             location: customer_contract_url(@contract, customer_id: @customer.id)
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1/contracts/2
  def update
    if @contract.update(contract_params)
      render json: @contract
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1/contracts/2
  def destroy
    @contract.destroy
  end

  # POST /contracts
  def bulk_create
    bulk_params.to_h[:contracts].each do |contract|
      Contract.delay.create(contract)
    end
    render json: {success: true}
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_contract
    @contract = @customer.contracts.find(params[:id])
  end

  def contract_params
    params.require(:contract).permit(:price, :start_date, :end_date, :expiry_date)
  end

  def bulk_params
    params.permit(contracts: [:price, :start_date, :end_date, :expiry_date, :customer_id])
  end
end
