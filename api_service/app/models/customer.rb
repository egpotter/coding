class Customer
  include Mongoid::Document

  field :address, type: String
  field :email, type: String
  field :name, type: String

  validates :address, :email, :name, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
