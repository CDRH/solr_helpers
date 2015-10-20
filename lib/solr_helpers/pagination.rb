module SolrHelpers::Pagination
  include ActionView::Helpers
  extend ActionView::Helpers

  # add_paginator_options
  #   params: range (1..3), params (rails param object or hash)
  #   returns: html as string with list of links
  def add_paginator_options(range, aParams=params)
    html = ""
    range.each do |page|
      html += "<li>"
      html += link_to page.to_s, to_page(page, aParams)
      html += "</li>"
    end
    return html
  end

  # paginator_numbers
  #   params: total_pages (12)
  #           display_range (default is 3, determines how many buttons appear in pagination on each side of current page)
  #           params (rails params or hash)
  #   returns: big html snippet that has been deemed html_safe, however unwisely
  #           contains first, current, and last pages in search results
  #           as well as padding the current page with the previous and next pages
  def paginator_numbers(total_pages, display_range=3, aParams=params)
    current_page = aParams[:page] ? aParams[:page].to_i : 1
    total_pages = total_pages.to_i
    html = ""
    # weed out the first and last page, they'll be handled separately
    prior_pages = (current_page-display_range..current_page-1).reject { |x| x <= 1 }
    next_pages = (current_page+1..current_page+display_range).reject { |x| x >= total_pages }

    # add the first page if you're not on it and add dots if it is far from the other pages
    if current_page != 1
      html += "<li>"
      html += link_to "1", to_page("1") 
      html += "</li>"
      html += "<li class='disabled'><span>...</span></li>" if prior_pages.min != display_range-1 && current_page != display_range-1
    end

    # prior pages, current page, and next pages
    html += add_paginator_options(prior_pages, aParams)
    html += "<li class='active'>"
    html += link_to current_page.to_s, to_page(current_page)
    html += "</li>"
    html += add_paginator_options(next_pages, aParams)

    # add the last page if you're not on it and add dots if it is far from the other pages
    if current_page != total_pages
      html += "<li class='disabled'><span>...</span></li>" if next_pages.max != total_pages-1 && current_page != total_pages-1
      html += "<li>"
      html += link_to total_pages.to_s, to_page(total_pages)
      html += "</li>"
    end

    return html.html_safe
  end

  # result_text
  #   purpose: get correct phrasing "1 result" vs "0 results" vs "10 results"
  #   params: number
  #   returns: "result" or "results" depending on which grammar is more appropriate
  def result_text(number)
    number = number.to_i
    text = number == 1 ? "result" : "results"
    return text
  end

  # to_page
  #   purpose: return the parameters rails will use to send a new request to a different page
  #            essentially want all the same parameters except for the page
  #   params: page ("3"), params (rails params or hash)
  #   returns: parameters for new rails request
  #   example:  <%= link_to "Next Page", to_page("5") %>
  def to_page(page, aParams=params)
    merged = aParams.merge({:page => page.to_s})
    return merged
  end
end