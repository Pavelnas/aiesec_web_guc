class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
    @url = 'https://auth.aiesec.org/users/sign_in'
    @url_op = 'https://aiesec.org/auth'
    @token = nil
    @max_age = nil
    @expiration_time = nil
    @password = nil
    self.auth(current_user.email ,session[:password])

  end

  def auth(email, password)
    @email = email
    @password = password
    agent = Mechanize.new {|a| a.ssl_version, a.verify_mode = 'TLSv1',OpenSSL::SSL::VERIFY_NONE}
    page = agent.get(@url)
    aiesec_form = page.form()
    aiesec_form.field_with(:name => 'user[email]').value = @email
    aiesec_form.field_with(:name => 'user[password]').value = @password

    begin
      page = agent.submit(aiesec_form, aiesec_form.buttons.first)
    rescue => exception
      puts exception.to_s
      false
    else
      if page.code.to_i == 200
        cj = page.mech.agent.cookie_jar.store
        index = cj.count
        for i in 0...index
          index = i if cj.to_a[i].domain == 'aiesec.org'
        end
        if index != cj.count
          params = cj.to_a[index].value
          data = JSON.parse(URI.decode(params))
          @token = data["token"]["access_token"]
          @expiration_time = cj.to_a[index].created_at
          @max_age = data["token"]["max_age"]
          puts "$$$$$$$$$"+@token
          session[:token] = @token
          true
        end
      end
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :email, :password)
    end
end
