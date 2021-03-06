class User < ApplicationRecord
	has_many :orders, dependent: :destroy
	has_many :addresses, dependent: :destroy
	
	validates_presence_of :first_name, :last_name, :email, :birtday
	validates :first_name, uniqueness: { case_sensitive: false }
	accepts_nested_attributes_for :addresses, allow_destroy: true
	validate :must_have_one_address

	def must_have_one_address
		errors.add(:addresses, 'must have one address') if addresses.empty?
	end
end
