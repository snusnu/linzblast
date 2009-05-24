# This file is specifically for you to define your strategies 
#
# You should declare you strategies directly and/or use 
# Merb::Authentication.activate!(:label_of_strategy)
#
# To load and set the order of strategy processing

# This strategy uses a login  and password parameter.
#
# Overwrite the :password_param, and :login_param
# to return the name of the field (on the form) that you're using the 
# login with.  These can be strings or symbols
#
# == Required
#
# === Methods
# <User>.authenticate(login_param, password_param)
#

Merb::Slices::config[:"merb-auth-slice-password"][:no_default_strategies] = true

class InvitationCode < Merb::Authentication::Strategy
  
  def run!
    Code.get request.params[:invitation_code]
  end
  
  def strategy_error_message
    "wrong codez"
  end
  
end

Merb::Authentication.activate!(:default_password_form)
Merb::Authentication.activate!(:default_basic_auth)