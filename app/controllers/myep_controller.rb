 class MyepController < ApplicationController
  def index

    member = Member.find(session[:member])
    @mailo = member.email
    params = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',q: @mailo}
    @responses = HTTParty.get("https://gis-api.aiesec.org/v2/people" , query:params )

    @managerss = @responses.parsed_response['data']

    @manager_idhat = @managerss[0]['id']

    paramss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page: 50 ,filters:{contacted_by: @manager_idhat}}
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






end
