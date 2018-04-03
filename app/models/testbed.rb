class Testbed < ApplicationRecord
	validates :testbed_name,:tb_urn, presence: true, uniqueness: true
	has_many :services, dependent: :destroy
	#validates :tb_urn, presence: true, uniqueness: true
end
