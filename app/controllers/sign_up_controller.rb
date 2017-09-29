class SignUpController < Devise::RegistrationsController
  def new
    build_resource({})
    yield resource if block_given?
    respond_with resource
    
  end
end
