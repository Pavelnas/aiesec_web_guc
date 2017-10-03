class DashBoardController < ApplicationController
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
  @manago = {}
  def openSource
  paramss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page: 50 ,filters:{home_committee: 257, has_managers: false}}
  @responsesat = HTTParty.get("https://gis-api.aiesec.org/v2/people" , query:paramss )
  @manago = @responsesat.parsed_response
  render 'index'
  end

  def display
    paramss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page: 50 ,filters:{home_committee: 257}}
    @responsesat = HTTParty.get("https://gis-api.aiesec.org/v2/people" , query:paramss )
    @manago = @responsesat.parsed_response

    render 'index'
  end

  def LC
    paramss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page: 50 ,filters:{home_committee: 257}}
    @responsesat = HTTParty.get("https://gis-api.aiesec.org/v2/people" , query:paramss )
    @manago = @responsesat.parsed_response
    @countries_array = Array.new
    @manago['data'].each do |ep|
      if ep['status'] != 'open'
        paramsss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',filters:{person_id:ep['id']}}
        @responsesatt = HTTParty.get("https://gis-api.aiesec.org/v2/applications" , query:paramsss )
        @managoo = @responsesatt.parsed_response

        @managoo['data'].each do |opp|
          x = opp['opportunity']['office']['name']
          @countries_array.push x
        end
      end
    end
    @countries_hash = Hash.new(0)

    @countries_array.each do |v|
      @countries_hash[v] += 1
    end
    render 'countries'

  end


  def countries
    paramss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page: 50 ,filters:{home_committee: 257}}
    @responsesat = HTTParty.get("https://gis-api.aiesec.org/v2/people" , query:paramss )
    @manago = @responsesat.parsed_response
    @countries_array = Array.new
    @manago['data'].each do |ep|
      if ep['status'] != 'open'
        paramsss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',filters:{person_id:ep['id']}}
        @responsesatt = HTTParty.get("https://gis-api.aiesec.org/v2/applications" , query:paramsss )
        @managoo = @responsesatt.parsed_response

        @managoo['data'].each do |opp|
          x = opp['opportunity']['office']['country']
          @countries_array.push x
        end
      end
    end
    @countries_hash = Hash.new(0)

    @countries_array.each do |v|
      @countries_hash[v] += 1
    end
    render 'countries'
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

    payload = {person: {manager_ids: [463322, 77022]}}
    payyload = payload.to_json
    params = {access_token: '18f69d4a3ece274a1ae40ffa763fe0826209c5d4bf5a1ccc33b72e16938a6ce6'}
    #HTTParty.options("https://gis-api.aiesec.org/v2/people/#{ep_id}",query:params)
    HTTParty.patch("https://gis-api.aiesec.org/v2/people/#{ep_id}.json",query:params)
    new

  end
  def opp

    paramsss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page:50}
    @responsesat = HTTParty.get("https://gis-api.aiesec.org/v2/opportunities" , query:paramsss )
    @managooo = @responsesat.parsed_response
    render 'booklet'
  end
  def filter_opp

    paramsss = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493',per_page:50}
    @responsesat = HTTParty.get("https://gis-api.aiesec.org/v2/opportunities" , query:paramsss )
    @managooo = @responsesat.parsed_response
    render 'booklet'
  end



end
