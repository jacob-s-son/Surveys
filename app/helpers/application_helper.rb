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
  
  def display_chart(question, chart_type, opts ={})
    send "#{chart_type}_chart", question, opts
  end
  
  def pie_chart(question, opts = {})
    data = question.type_is?('option') ? question.data_for_chart : []
    
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Option') #TODO: need to add a new key to tranlations yml and use its ID for easier internationalization 
    data_table.new_column('number', 'Votes')
    data_table.add_rows data

    opts   = { :width => 400, :height => 240, :title => "", :is3D => true }.merge opts
    chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)
    
    render_chart chart, "chart_#{question.id}"
  end
  
  def matched_answer_content(content, query)
    "<span class=\"portion_matched\">#{ content.match(/#{query}/).to_s }</span>"
  end
  
  def user_answer_content(ua, query)
    query.gsub! /%/, ''
    "<span>#{ua.content.sub /#{query}/, matched_answer_content(ua.content, query) }</span>".html_safe
  end
end
