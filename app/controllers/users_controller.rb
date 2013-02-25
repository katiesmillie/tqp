class UsersController < ApplicationController
  before_filter :authenticate_user!
  
    def show
      @pair=current_user.pair
      
    end

end
