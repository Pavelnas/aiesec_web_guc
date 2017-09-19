class ControlsController < ApplicationController
  def login
    if request.post?
      @member_loged = Member.find_by(:email => params[:email], :password=>params[:password])
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
