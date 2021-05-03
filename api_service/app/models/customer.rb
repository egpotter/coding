# frozen_string_literal: true

class Customer
  include Mongoid::Document

  field :address, type: String
  field :email, type: String
  field :name, type: String

  has_many :contracts, dependent: :destroy

  validates :address, :email, :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
