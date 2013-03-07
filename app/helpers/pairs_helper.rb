module PairsHelper
  
  def partnered
    @partnered = "That person already has a partner"
  end
  
  def search_result(partners)
    if partners.count > 0
      yield
    end
  end
  
  
  
end
