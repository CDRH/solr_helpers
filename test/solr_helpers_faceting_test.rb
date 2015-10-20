require 'test_helper'
include SolrHelpers::Faceting

class SolrHelpersTest < ActiveSupport::TestCase
  params = {
    "controller" => "static",
    "action" => "show",
    "page" => "4",
    "qfield" => "text",
    "qtext" => "water",
    "novel" => "emma",
    "sex" => "female"
  }

  # a copy so we can make sure that params isn't being altered by below
  orig_params = params.clone

  test "faceting_exists" do
    assert_kind_of Module, SolrHelpers::Faceting
  end

  test "clear_search" do
    response = clear_search(params)
    assert_equal response, {
      "controller" => "static",
      "action" => "show",
      "page" => "4",
      "novel" => "emma",
      "sex" => "female"
    }
    assert_equal params, orig_params
  end

  test "facet_link" do
    response = facet_link("character", "emma", params)
    assert_nil response["page"]
    assert_equal response["character"], "emma"
    assert_equal params, orig_params
  end

  test "facet_selected?" do
    no_facet = facet_selected?("character", "emma", params)
    assert_not no_facet
    selected = facet_selected?("sex", "female", params)
    assert selected
    not_selected = facet_selected?("novel", "pride_and_prejudice", params)
    assert_not not_selected
  end

  test "remove_facet" do
    response = remove_facet("sex", params)
    assert_equal response, {
      "controller" => "static",
      "action" => "show",
      "qfield" => "text",
      "qtext" => "water",
      "novel" => "emma"
    }
    assert_nil response["page"]
    assert_nil response["sex"]
    assert_equal params, orig_params
  end

  test "reset_general_params!" do
    new_params = params.clone
    response = reset_general_params!(new_params)
    assert_nil new_params["page"]
    assert_nil response["page"]
    assert_equal params, orig_params
  end
end