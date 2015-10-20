module SolrHelpers::Sorting
  include ActionView::Helpers
  extend ActionView::Helpers 

  # sort
  #   params: sort_type ("novel", "relevance"), params (rails params)
  #   returns: rails params for new request
  # NOTE: does not use "asc" "desc" which are currently in controllers, maybe that
  #   should change, though?
  def sort(sort_type, aParams=params)
    new_params = aParams.clone
    new_params["sort"] = sort_type
    new_params.delete("page")
    return new_params
  end

end