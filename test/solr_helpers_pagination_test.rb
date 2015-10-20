require 'test_helper'
include SolrHelpers::Pagination

class SolrHelpersTest < ActiveSupport::TestCase
  params = {
    :controller => "static",
    :action => "show",
    :qfield => "text",
    :qtext => "water",
    :novel => "emma",
    :page => "3"
  }

  test "pagination_exists" do
    assert_kind_of Module, SolrHelpers::Pagination
  end

  # Rails.application.routes.draw do
  #   get "show" => "static#show"
  # end

  # TODO figure out how to get link_to -> url_for to work
  # which is to say that I suspect it is using the wrong module for link_to
  
  # test "add_paginator_options" do
  #   numbers = add_paginator_options(1..3, params)
  #   assert_equal numbers, ""
  # end

  test "result_text_examples" do
    assert_equal result_text(1), "result"
    assert_equal result_text(0), "results"
    assert_equal result_text(2), "results"
    assert_equal result_text(nil), "results"
  end

  test "to_page" do
    results = to_page("4", params)
    assert_equal results[:page], "4"
    assert_equal params[:page], "3"
  end

end