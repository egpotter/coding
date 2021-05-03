class ContractsController < ApplicationController
  before_action :set_customer
  before_action :set_contract, only: [:show, :update, :destroy]

  # GET /contracts
  def index
    @contracts = Contract.all

    render json: @contracts
  end

  # GET /contracts/1
  def show
    render json: @contract
  end

  # POST /contracts
  def create
    @contract = @customer.contracts.new(contract_params)

    if @contract.save
      render json: @contract, status: :created,
        location: customer_contract_url(@contract, customer_id: @customer.id)
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contracts/1
  def update
    if @contract.update(contract_params)
      render json: @contract
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contracts/1
  def destroy
    @contract.destroy
  end

  private
    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def set_contract
      @contract = @customer.contracts.find(params[:id])
    end

    def contract_params
      params.require(:contract).permit(:price, :start_date, :end_date, :expiry_date, :customer_id)
    end
end
