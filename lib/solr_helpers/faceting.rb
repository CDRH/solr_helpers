module SolrHelpers::Faceting
  include ActionView::Helpers
  extend ActionView::Helpers 


  # clear_search
  #   params: rails params object or hash
  #   returns: new params object with the qfield / qtext / q query fields removed
  #   NOTE:  This will leave facets intact
  def clear_search(aParams=params)
    new_params = aParams.clone
    new_params.delete("qfield")
    new_params.delete("qtext")
    new_params.delete("q")
    return new_params
  end

  # facet_link
  #   params: facet_type ("novel"), facet ("emma"), params (rails params)
  #   returns: returns params with requested facet and no page
  def facet_link(facet_type, facet, aParams=params)
    new_params = aParams.clone
    reset_general_params!(new_params)
    new_params[facet_type] = facet
    return new_params
  end

  # facet_selected?
  #   params: facet_type ("novel"), facet ("emma"), params (rails params)
  #   returns: boolean indicating whether given facet_type and facet are part of parameters
  def facet_selected?(facet_type, facet, aParams=params)
    # this is just a really handy debug line, so I'm keeping it
    # puts "facet type #{facet_type}, facet #{facet}, and in params #{aParams[facet_type]}"
    return aParams[facet_type] == facet
  end

  # remove_facet
  #   params: facet_type ("novel"), params (rails params)
  #   returns: params without the given facet_type
  def remove_facet(facet_type, aParams=params)
    new_params = aParams.clone
    reset_general_params!(new_params)
    new_params.delete(facet_type)
    return new_params
  end

  # reset_general_params!
  #   params: params (rails style params object, must be passed in to avoid mistakes)
  #   returns: params without some pretty general fields
  #   CAUTION: Destructive method!
  #   NOTE: does not reset "sort" nor search query / faceting
  def reset_general_params!(aParams)
    aParams.delete("facet.field")
    aParams.delete("page")
    return aParams
  end
end