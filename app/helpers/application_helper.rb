module ApplicationHelper
  
  # Add for admin dashboard
  def notice_message
    alert_types = {:notice=>:success , :alert=>:danger}

    close_button_options = {:class=>"close", "data-dismiss" => "alert", "aria-hidden"=>true}
    close_button = content_tag(:button, "x" , close_button_options)

    alerts = flash.map do |type, message|
      alert_content = close_button + message
      
      #??
      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dissable"
      content_tag(:div , alert_content, :class=>alert_class)
    
    end
    
    #change array to string
    #print raw html tag to view
    alerts.join("\n").html_safe
  end


  def path_with_hash_tag(path)
    path.slice!(0) if path.start_with?('/')
    "##{path}"
  end

  def path_without_backslash(path)
    path.slice!(0) if path.start_with?('/')
    "#{path}"
  end

  def url_with_hash_tag(path)
    "#{root_url}#{path_with_hash_tag(path)}"
  end


  def list_error_messages(error_messages_array)
    str = ""
    error_messages_array.each_with_index do |element, index|
      str = str + "#{index + 1}. #{element}                              "
    end

    raw(str)
  end


  def render_format_time(datetime)
    datetime.strftime("%Y/%m/%d") 
  end



  # change the default link renderer for will_paginate
  # def will_paginate(collection_or_options = nil, options = {})
  #   if collection_or_options.is_a? Hash
  #     options, collection_or_options = collection_or_options, nil
  #   end
  #   unless options[:renderer]
  #     options = options.merge :renderer => MyCustomLinkRenderer
  #   end
  #   super *[collection_or_options, options].compact
  # end

end



# class MyCustomLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
#   def link(text, target, attributes = {})
#     if target.is_a? Fixnum
#       attributes[:rel] = rel_value(target)
#       target = url(target)
#     end
#     attributes[:href] = target
#     tag(:a, text, attributes)
#   end

#   def url(path)
#     "##{path}"
#   end
# end


