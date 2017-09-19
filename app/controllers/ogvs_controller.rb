class OgvsController < ApplicationController
  def new
    @iid = Ogv.new
  end
  def create
  @project  = Ogv.new(id_param)
  @x = @project.project_id
  params = {access_token: 'e316ebe109dd84ed16734e5161a2d236d0a7e6daf499941f7c110078e3c75493'}
  @response = HTTParty.get("https://gis-api.aiesec.org/v2/opportunities/#{@x}" , query:params )
  @managers = @response.parsed_response

  render 'create'
  end
  private
  def id_param
    params.require(:ogv).permit(:project_id)
  end
end
