class Admin::UsersController < Admin::BaseController

	before_filter :admin_required;

	def index
		@users = User.all
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "User added"
		else 
			flash[:danger] = "Something went wrong"
		end	
		redirect_to :action => "index"
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params) 
			render json: @user
		else 
			render json: @user
		end
		
	end

	def destroy
		if User.find(params[:id]).destroy
			flash[:success] = "Job #{params[:id]} deleted"
		else 
			flash[:danger] = "Something went wrong"
		end
		redirect_to :action => "index"
	end

	private
		def user_params
			params.require(:user).permit(:id, :first_name, :last_name, :email, :password)
		end

end
