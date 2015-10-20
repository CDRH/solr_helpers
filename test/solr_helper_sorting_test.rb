require 'test_helper'
include SolrHelpers::Sorting

class SolrHelpersTest < ActiveSupport::TestCase
  params = {
    "page" => "4",
    "sort" => "relevance",
    "novel" => "emma",
    "qfield" => "text",
    "qtext" => "water"
  }
  test "sort" do
    response = sort("novel", params)
    assert_nil response["page"]
    assert_equal params["page"], "4"
    assert_equal response["sort"], "novel"
  end
end