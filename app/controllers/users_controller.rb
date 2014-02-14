class UsersController < ApplicationController

	def test
		render :test
	end

	def add
		l = User.add(params[:user], params[:password])
		if l>0
		  render json: {errCode: 1, count: l}
		else
		  render json: {errCode: l}
		end
	end

	def login
		l = User.login(params[:user], params[:password])
		if l>0
		  render json: {errCode: 1, count: l}
		else
		  render json: {errCode: l}
		end
	end

	def reset_fixture
		User.destroy_all
		render json: {errCode: 1}
	end

	def unit_tests
		output = `rspec #{Rails.root}/spec/`
		nrFailed = /(\d+) failures/.match(output)[1]
		totalTests = /(\d+) example/.match(output)[1]
		render json: {nrFailed: int(nrFailed), output: output, totalTests: int(totalTests)x}
	end	

end