defmodule BookwyrmWeb.Test.Schema.GetBookBySlugTest do
  use Bookwyrm.DataCase, async: true
  use Wormwood.GQLCase

  load_gql(BookwyrmWeb.Schema.Schema, "test/support/queries/GetBookBySlug.gql")

  describe "GetBooksBySlug.gql" do
    test "should return The Name of the Wind" do
      result = query_gql(variables: %{"slug" => "the-name-of-the-wind"})
      {:ok, query_data} = result
      book = get_in(query_data, [:data, "book"])
      assert book["title"] == "The Name of the Wind"
      assert book["description"] == "The Name of the Wind is a heroic fantasy novel."
      assert book["isbn13"] == 9_780_756_404_079
      assert book["slug"] == "the-name-of-the-wind"
    end
  end
end
