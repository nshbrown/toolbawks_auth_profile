# Copyright (c) 2007 Nathaniel Brown
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module ApplicationHelper
  def toolbawks_auth_profile_head
    <<-EOL
      #{ stylesheet_link_tag 'Toolbawks.address.css', :plugin => 'toolbawks_auth_profile' }
      #{ javascript_include_tag 'Toolbawks.address.js', 'Toolbawks.address.Box.js', :plugin => 'toolbawks_auth_profile' }
EOL
  end
  
  def get_options_states_for_country(country)
    case country
      when 'us'
        return ToolbawksAuthProfile.us_states
      when 'ca' || 'canada'
        return ToolbawksAuthProfile.canada_states
      when 'india'
        return ToolbawksAuthProfile.india_states
      when 'australia'
        return ToolbawksAuthProfile.australia_states
    end
  end
  
  def country_select_options_html(opt = {})
    if !opt[:name]
      logger.error 'ToolbawksAuthProfile.application_helper.country_select_options_html -> no name was passed'
      return
    end
    
    html = []
    
    select_options = []
    select_options << ['id', opt[:id]]
    select_options << ['name', opt[:name]]
    select_options << ['class', opt[:css]]
    
    select_options = select_options.collect { |o| (o[0] + '="' + o[1] + '"') }.join(' ')

    html << '<select ' + select_options + '>'
    
#    logger.info 'country_select_options_html -> select : ' + html.inspect

    selected = opt[:selected]
    
    priority_countries = [{
      :label => 'Please Select...',
      :value => ''
    }]
    
    priority_countries |= ToolbawksAuthProfile.priority_countries
    
#    logger.info 'country_select_options_html -> country_options : ' + priority_countries.inspect

    priority_countries.each do |option|
      if option.has_key?(:children)
        disabled = ''
        
        if country_group_disabled?(opt, option[:label])
          disabled = ' disabled="true"'
          next if ToolbawksAuthProfile.country_groups[:hide_disabled]
        end
        
        html << '<optgroup label="' + option[:label] + '"' + disabled + '>'
        
        option[:children].each do |option_child|
          html << '<option' + ((selected == option_child) ? ' selected="true"' : '') + '>' + option_child + '</option>'
        end
          
        html << '</optgroup>'
      else
        html << '<option' + (option[:value] ? " value=\"#{ option[:value] }\"" : '') + ((selected == option[:label]) ? ' selected="true"' : '') + '>' + "#{ h option[:label] }" + '</option>'
      end
    end
    
    html << '</select>'
    
    # logger.info 'country_select_options_html -> html : [[%%' + html.join('') + '$$]]'
    
    return html.join("\n")
  end
  
  def country_group_disabled?(opt, country)
    if opt[:disabled].class == String && opt[:disabled] == country
      return true
    elsif opt[:disabled].class == Array && opt[:disabled].include?(country)
      return true
    else
      return false
    end
  end
end