class UsersController < ApplicationController
  before_action :authorize, only: [:index]
  def index
    @users = User.all
  end
  def new
     unless current_user
      @user = User.new
    else
      redirect_to '/'
    end

  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "sucessfull sign up....Welcome to the Todo App!"

      redirect_to '/'
    else
      flash[:danger] = "please fill correct infornation.." # Not quite right!
      #redirect_to '/signup'
      render 'users/new'
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
      @user = User.find(params[:id])
      if (params[:user][:password] == params[:user][:password_confirmation]) && (params[:user][:password] != "")
        password = BCrypt::Password.create(params[:user][:password])
        if @user.update_column(:password_digest, password )
          flash[:success] = 'User was successfully updated.'
          redirect_to users_path
          #format.html { redirect_to @todo }
          #format.json { render :show, status: :ok, location: @todo }
        else
          flash[:danger] = 'There was a problem updating the User.'
          #format.html { render :edit }
          render 'users/edit'
          #  format.json { render json: @todo.errors, status: :unprocessable_entity }
        end
      else
        @user.errors.add :password, "and confirm password must be same..."
        render 'users/edit'
      end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
