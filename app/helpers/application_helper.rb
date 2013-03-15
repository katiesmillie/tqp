module ApplicationHelper
  
  def gravatar_for user, options = {}
      options = {:alt => 'avatar', :class => 'avatar', :size => 80}.merge! options
      id = Digest::MD5::hexdigest user.email.to_s.strip.downcase
      url = 'http://www.gravatar.com/avatar/' + id + '.jpg?s=' + options[:size].to_s
      options.delete :size
      image_tag url, options
  end
  
  def record_mixpanel(mixpanel_to_record)
      "<script type='text/javascript'>mpmetrics.track(#{mixpanel_to_record});</script>" if mixpanel_to_record.present? 
      #it'll only fire, if there is some event to record.
   end
  
end
