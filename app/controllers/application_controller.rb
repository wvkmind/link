class ApplicationController < ActionController::Base
  before_action :check_token
  def check_token
    unless @skip_check_token
      begin
        login_name = params[:login_name]
        password =  Digest::MD5.hexdigest(params[:password])
        @user = User.find_by login_name: login_name
        if @user.password != password
          render json: {code: 1200, msg: '登陆失败'}
        end
      rescue
        render json: {code: 1200, msg: '登陆失败'}
      end
    end
  end
  def skip_check_token
    @skip_check_token = true
  end
end
