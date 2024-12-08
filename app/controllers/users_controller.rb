class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    skip_before_action :authorized, only: [:index, :show] # Public pages không yêu cầu login
  
    # Danh sách tất cả người dùng (Public)
    def index
      @users = User.all # Có thể thêm logic để lọc người dùng
    end
  
    # Xem thông tin chi tiết hồ sơ của một user
    def show
      @matches = @user.matches
      @swipes = @user.swipes
      @messages = @user.messages
    end
  
    # Trang chỉnh sửa hồ sơ (Private)
    def edit
      redirect_to root_path, alert: "Bạn không có quyền chỉnh sửa" unless @user == current_user
    end
  
    # Cập nhật hồ sơ (Private)
    def update
      if @user.update(user_params)
        redirect_to @user, notice: "Cập nhật thành công"
      else
        render :edit, alert: "Có lỗi xảy ra"
      end
    end
  
    # Xóa tài khoản (Private)
    def destroy
      if @user == current_user
        @user.destroy
        redirect_to root_path, notice: "Tài khoản của bạn đã được xóa"
      else
        redirect_to root_path, alert: "Bạn không có quyền xóa tài khoản này"
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :bio, :image, :age, :gender)
    end
  end
  