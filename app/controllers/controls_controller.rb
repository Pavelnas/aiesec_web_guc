class ControlsController < ApplicationController
  
  def login
    if request.post?
      @member_loged = Member.find_by(:email => params[:email], :password=>params[:password])
      @url = 'https://auth.aiesec.org/users/sign_in'
      @url_op = 'https://aiesec.org/auth'
      @token = nil
      @max_age = nil
      @expiration_time = nil
      @password = nil
      #auth(params[:email] ,params[:password])


      if !@member_loged.nil?
        session[:member] = @member_loged.id
        redirect_to root_url , notice: "Thank you for signing up"
      else
        respond_to do |format|
          format.html{render :new }
          format.json {render json: @member.errors , status: :unprocessable_entity}
        end
      end
    end
  end
end
