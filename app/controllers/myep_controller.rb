 class MyepController < ApplicationController
  def index

    #member = Member.find(session[:member])
    @mailo = current_user.email
    params = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',q: @mailo}
    @responses = HTTParty.get("https://gis-api.aiesec.org/v2/people" , query:params )

    @managerss = @responses.parsed_response['data']

    @manager_idhat = @managerss[0]['id']

    paramss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page: 50 ,filters:{contacted_by: @manager_idhat}}
    @responsesat = HTTParty.get("https://gis-api.aiesec.org/v2/people" , query:paramss )
    @manago = @responsesat.parsed_response
    render 'index'
  end
  def openSource
  paramss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page: 50 ,filters:{home_committee: 257}}
  @responsesat = HTTParty.get("https://gis-api.aiesec.org/v2/people" , query:paramss )
  @manago = @responsesat.parsed_response
  render 'index'
  end
  def display
    paramss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page: 50 ,filters:{home_committee: 257, has_managers: false}}
    @responsesat = HTTParty.get("https://gis-api.aiesec.org/v2/people" , query:paramss )
    @manago = @responsesat.parsed_response
    render 'index'

  end
  def new
    ep_id = params['ep_id']
    paramsss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',filters:{person_id:ep_id}}
    @responsesatt = HTTParty.get("https://gis-api.aiesec.org/v2/applications" , query:paramsss )
    puts @responsesatt
    @managoo = @responsesatt.parsed_response
    render 'new'

  end
  def show
    ep_id = params['ep_id']
    params = {access_token: 'dc2f9f8e7e2a0dc56fe48fc302d0ce85b9916a1aecb2af98e36bdfebb414f361'}
    @response = HTTParty.patch("gis-api.aiesec.org/v2/people/#{ep_id}.json",query:params)
    render 'index'
  end






end
