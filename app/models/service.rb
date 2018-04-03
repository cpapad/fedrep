class Service < ApplicationRecord
	validates :service_name, presence: true		
	belongs_to :testbed
end
