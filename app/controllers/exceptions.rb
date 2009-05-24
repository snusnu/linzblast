class Exceptions < Merb::Controller
  
  def unauthenticated
    provides :xml, :js, :json, :yaml
     
    case content_type
    when :html
      if status == Unauthenticated.status
        message[:auth_status] = session.authentication.error_message
      end
      render :layout => :authentication
    else
      basic_authentication.request!
      ''
    end
  end
  
  # handle NotFound exceptions (404)
  def not_found
    render :format => :html
  end

  # handle NotAcceptable exceptions (406)
  def not_acceptable
    render :format => :html
  end

end