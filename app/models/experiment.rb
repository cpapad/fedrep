class Experiment < ApplicationRecord
	validates :rstart, :rend, :slice_urn, presence: true, uniqueness: true	
	belongs_to :user
	

	#def increment_exp(user)
	#	user.experiments+=1
	#end
end
