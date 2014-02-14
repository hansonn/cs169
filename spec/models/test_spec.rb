require 'spec_helper'

describe Test do
	it "1. create user with user_name empty" do
		result = User.add('','wordpass')
		expect(result).to eq(User::ERR_BAD_USERNAME)
	end

	it "2. create user with user_name longer than 128 charcters" do
		result = User.add('ahfoahfhafhapehfaiwehfpaiohwefpiahwepofhapwehfopahefpiahwepofhawpoefhapwouehfpaiowhefpiaohwepfahwpeoufhapwoiehfpaowuehfpaiwuehfpaiwuehfapwiefhapiwe','wordpass')
		expect(result).to eq(User::ERR_BAD_USERNAME)
	end

	it "3. create user with password longer than 128 characters" do
		result = User.add('user','ahfoahfhafhapehfaiwehfpaiohwefpiahwepofhapwehfopahefpiahwepofhawpoefhapwouehfpaiowhefpiaohwepfahwpeoufhapwoiehfpaowuehfpaiwuehfpaiwuehfapwiefhapiwe')
		expect(result).to eq(User::ERR_BAD_PASSWORD)
	end

	it "4. create user duplicated user_name" do
		User.add('user1','wordpass')
		result = User.add('user1','wordpass')
		expect(result).to eq(User::ERR_USER_EXISTS)
	end

	it "5. create a new user and success" do
		result = User.add('user1','wordpass')
		expect(result).to eq(User::SUCCESS)
	end

	it "6. log in with non-exist user name" do
		result = User.login('user6','wordpass')
		expect(result).to eq(User::ERR_BAD_CREDENTIALS)
	end

	it "7. log in with wrong password" do
		#result = User.add('user7','wordpass')
		result = User.login('user1','wordpas')
		expect(result).to eq(User::ERR_BAD_CREDENTIALS)
	end

	it "8. create user with correct info" do
		User.add('user8','wordpass')
		User.add('user8.1','wordpass')
		result = User.login('user8','wordpass')
		expect(result).to eq(2)
	end

	it "9. check log in 5 times" do
		User.add('user9','wordpass')
		User.login('user9','wordpass')
		User.login('user9','wordpass')
		User.login('user9','wordpass')
		result = User.login('user9','wordpass')
		expect(result).to eq(5)
	end

		it "10. check log in 10 times" do
		User.add('user9','wordpass')
		User.login('user9','wordpass')
		User.login('user9','wordpass')
		User.login('user9','wordpass')
		User.login('user9','wordpass')
		User.login('user9','wordpass')
		User.login('user9','wordpass')
		User.login('user9','wordpass')
		User.login('user9','wordpass')
		result = User.login('user9','wordpass')
		expect(result).to eq(10)
	end
end