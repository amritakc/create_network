class UsersController < ApplicationController

 	def index
 	end

 	def create
 		if params[:password2] == params[:password]
			@new_user = User.create(name:params[:name], email: params[:email], password:params[:password], description:params[:description])
			if @new_user.invalid? 
				flash[:error] = @new_user.errors.full_messages
				redirect_to '/main'
			else
				@users = User.last
				session[:user_id] = @users.id
				redirect_to '/professional_profile'
			end
		else
			flash[:errors] = "passwords don't match"
			redirect_to '/main'
		end
	end	

	def create_returning_user
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			session[:name] = user.name
			redirect_to '/professional_profile' % session[:user_id], :notice => "Logged in!"
		else
			flash[:errors] = 'Invalid email or password'
			redirect_to '/main'
		end
	end

	def show
		@user = User.find(session[:user_id])
		@friends = User.find(session[:user_id]).friends
	end

	def show_users
		@users = User.where.not(id:session[:user_id])
	end

	def profile
		@profile = User.find(params[:id])
	end

	def create_pending
		Friendship.create(user:User.find(session[:user_id]),friend:User.find(params[:id]),invite:'p')
		redirect_to '/users'
	end

	def create_friendship
		Friendship.create(user:User.find(session[:user_id]), friend: User.find(params[:id]), invite: 't')
		User.find(session[:user_id]).friendships.where(friend:User.find(params[:id])).first.destroy
		redirect_to '/professional_profile'
	end

	def destroy_invite
		User.find(session[:user_id]).friendships.where(friend:User.find(params[:id])).first.destroy
		redirect_to '/professional_profile'
	end

	def delete_session
		# session.clear
		session[:user_id] = nil
		redirect_to '/main'
	end


end
