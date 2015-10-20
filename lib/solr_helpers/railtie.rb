module SolrHelpers
  class Railtie < Rails::Railtie
    initializer "solr_helpers.configure_view_controller" do |app|
      ActiveSupport.on_load :action_view do
        include SolrHelpers::Pagination
        include SolrHelpers::Faceting
        include SolrHelpers::Sorting
      end

      # This is probably not in the spirit of this view oriented gem but 
      # I want to keep the comment so I can find how to do it in the future
      # ActiveSupport.on_load :action_controller do
      #   include SolrHelpers::SomethingForControllers
      # end
    end
  end
end