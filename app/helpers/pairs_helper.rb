module PairsHelper
  

  def search_result(partners)
    if partners.count > 0
      yield
    end
  end
  
  
  
end
