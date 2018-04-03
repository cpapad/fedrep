class ReputationController < ApplicationController
	
	before_action :rate_params, only: [:userqoe]
		
	def userqoe
		puts params[:user_urn]
		@user = User.where(:user_urn => params[:user_urn]).first_or_create!
		@exp = @user.experiments.where(:rstart => params[:start_time], :rend => params[:end_time], :slice_urn => params[:slice_urn], :user_urn => @user.user_urn).first_or_create!
	        if @exp.rated
			render :json => {"message" => "experiment already rated"}, status: 400
			return
		end
		testbeds = Array.new(params[:resources].length)
		params[:resources].each_with_index do |tb, i|
			testbeds[i] = Testbed.where(:tb_urn => tb.split("+")).take
			if !testbeds[i].nil? 
				testbeds[i].experiments += 1
				testbeds[i].save
			else
			
				render :json => {"message" => "Testbed #{tb.split("+")[0]} not found"}, status: 400
				return
			end

		end

		ratings = Kpi.new
		ratings.score = params[:user_eval]
		puts ratings.score
		#puts params[:user_eval]
		#puts testbeds.inspect
		#puts a
		ratings.rep_calc
		render :json => @exp
		
	end

	


	private
	def rate_params
		user_eval_keys = params[:user_eval].keys
		params.permit(:user_urn, :slice_urn, :start_time, :end_time, {:resources => []}, user_eval: user_eval_keys)
	end

end
