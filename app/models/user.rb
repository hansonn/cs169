class User < ActiveRecord::Base
	SUCCESS = 1
	ERR_BAD_CREDENTIALS = -1
	ERR_USER_EXISTS = -2
	ERR_BAD_USERNAME = -3
	ERR_BAD_PASSWORD = -4
	MAX_USERNAME_LENGTH = 128
	MAX_PASSWORD_LENGTH = 128

	def self.login(user_name, pwd)
		#check exists - success
		#count+1
		#return success
		user = User.find_by(user_name: user_name)
		if user==nil
			return ERR_BAD_CREDENTIALS
		end

		count = user.count
		if user.password == pwd
			count = count + 1
			user.count = count
			user.save
			return count
		else
			return ERR_BAD_CREDENTIALS
		end
		#else return bad_credentials
	end

	def self.add(user_name, pwd)
		#check USER_EXISTS
		if user_name.length>MAX_USERNAME_LENGTH || user_name.length==0
			return ERR_BAD_USERNAME
		elsif pwd.length > MAX_PASSWORD_LENGTH
			return ERR_BAD_PASSWORD
		else
			user = User.find_by(user_name: user_name)
			if user!=nil
				return ERR_USER_EXISTS
			end
			self.create(user_name: user_name, password: pwd, count: 1)
			return 1
		end
		#check PASSWORD

		#check USERNAME

		#SUCCESS
		#user.count = 1
	end
end
