class UsersController < ApplicationController
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
        @user = User.find(params[:id])
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
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    private
        def user_params
            params.require(:user).permit(:name, :description, :town, :count, :username, :email)
        end
end
