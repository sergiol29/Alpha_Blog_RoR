class UsersController < ApplicationController

    # use before_action for eliminate "@user = User.find(params[:id])" in method edit, show and update
    before_action :set_user, only: [:edit, :show, :update]

    # required logged all method for look views 
    before_action :required_user

    # required logged and only permit edit, update in your user
    before_action :require_same_user, only: [:show, :edit, :update]

    def index
        @user = User.all
    end 

    def new
        @user = User.new
    end

    def create
        #render plain: params(:user].inspec[:id])
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "User was successfully created"
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def update
        #render plain: params(:user].inspec[:id])
        #@user = User.find(params[:id]) 
        if @user.update(user_params)
            flash[:success] = "User was successfully update"
            redirect_to user_path(@user)
        else
            render 'edit'
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "User was successfully delete"
        redirect_to users_path
    end

    def show
        #@user = User.find(params[:id])
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def edit
        #@user = User.find(params[:id])
    end

    def set_user
        @user = User.find(params[:id])
    end 

    def require_same_user
        if current_user != @user
          flash[:danger] = "You can only show, edit or delete your own account"
          redirect_to users_path
        end
      end

    private
        def user_params
            params.require(:user).permit(:name, :description, :town, :count, :username, :email, :password)
        end
end
