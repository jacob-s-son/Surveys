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
  
  def answer_options(ua)
    ua.question.answers.map {|a| [ a.content, a.id ] }
  end
  
end
