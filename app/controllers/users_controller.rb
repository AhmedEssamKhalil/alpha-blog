class UsersController < ApplicationController
    
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]
    def new
        @user = User.new
        
    end
    
    def each
        @user = User.all
    end
        
    end
    
    
    def create
       @user = User.new(user_params)
       if @user.save
           session[:user_id] = @user.id
           flash[:success] = "Welcome To The Alpha-Blog #{@user.username}"
           redirect_to user_path(@user)
       else
           render 'new'
       end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "Your Account Was Updated Successfully"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    
   def show
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end
    
    def destroy
       @user = User.find(params[:id])
       @user.destroy
       flash[:danger] = "User and All Articles Created by User have been Deleted !"
       redirect_to users_path
    end
    
    def index
      @user = User.paginate(page: params[:page], per_page: 5)
    end
  

   
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
         @user = User.find(params[:id])
    end
    
    def require_same_user
        if current_user != @user and !current_user.admin?
            flash[:danger] = "you can only edit your own Account"
            redirect_to root_path
        end
    end
    
    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Only Admin Users Can perform that Action"
            redirect_to root_path
        end
    end