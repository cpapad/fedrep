class User < ApplicationRecord
	validates :user_urn, presence: true, uniqueness: true
	has_many :experiments, before_add: :increment_exp

	def increment_exp(experiment)
		self.exp_count+=1
        	self.save  	

	end
end
