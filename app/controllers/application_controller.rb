class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def doom
    render html: 'doom'
  end
end
