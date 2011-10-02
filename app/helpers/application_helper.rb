module ApplicationHelper
  def notice_type
    case true
      when flash[:notice]
        'notice'
      when flash[:error]
        'error'
      else
        'none'
    end
  end
  
  def has_notice?
    notice_type == 'none'
  end
end
