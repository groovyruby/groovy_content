class ApplicationController < ActionController::Base
  protect_from_forgery

  
  helper_method :s

  private

  def s(identifier)
    Setting.get(identifier)
  end

end
