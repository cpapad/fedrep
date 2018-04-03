class TestbedController < ApplicationController
	def create
		@testbed = Testbed.create(testbed_name: testbed_params[:testbed], tb_alias: testbed_params[:alias], tb_urn: testbed_params[:testbed])
		Rails.logger.debug("save outout #{@testbed.errors.messages}")
		if @testbed.errors.empty?
				testbed_params[:services].each do |ser|
					@service = @testbed.services.create(service_name: ser)
				        	
				end
		else
			render json: @testbed.errors
			return		
		end
			render json: @testbed
			
			#render json: @testbed.errors
				
	
		
		
	end

# Never trust parameters from the scary internet, only allow the white list through.
	
	def testbed_params
		params.require(:testbed)
		params.permit(:testbed, :alias, {:services => []}, :type)
	end

end
