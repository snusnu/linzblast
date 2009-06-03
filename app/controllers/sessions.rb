class MerbAuthSlicePassword::Sessions < MerbAuthSlicePassword::Application

  after :redirect_after_login,  :only => :update, :if => lambda { !(300..399).include?(status) }
  after :redirect_after_logout, :only => :destroy
  
  # @overwritable
  def redirect_after_login
    message[:auth_status] = 'success logged-in'
    if session.user
      redirect_back_or "/admin/dashboard", :message => message, :ignore => [slice_url(:login), slice_url(:logout)]
    else
      redirect initialized_game
    end
  end
  
  # @overwritable
  def redirect_after_logout
    message[:auth_status] = 'success logged-out'
    redirect "/", :message => message
  end
  
  private
  
  def initialized_game
    Game.create(:code_id => params[:code_id])
  end
  
end