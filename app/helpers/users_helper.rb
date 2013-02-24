module UsersHelper
  
  def full_name(user)
    @full_name = "#{current_user.first_name} #{current_user.last_name}".downcase
  end
  
end
