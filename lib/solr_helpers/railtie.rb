module SolrHelpers
  class Railtie < Rails::Railtie
    initializer "solr_helpers.configure_view_controller" do |app|
      ActiveSupport.on_load :action_view do
        include SolrHelpers::Pagination
        include SolrHelpers::Faceting
        include SolrHelpers::Sorting
      end

      # ActiveSupport.on_load :action_controller do
      #   include CdrhPagination::SomethingForControllers
      # end
    end
  end
end