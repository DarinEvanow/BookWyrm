defmodule BookwyrmWeb.Test.Schema.GetAuthorBySlugTest do
  use Bookwyrm.DataCase, async: true
  use Wormwood.GQLCase

  load_gql(BookwyrmWeb.Schema.Schema, "test/support/queries/GetAuthorBySlug.gql")

  describe "GetAuthorBySlug.gql" do
    test "should return Terry Pratchett" do
      result = query_gql(variables: %{"slug" => "terry-pratchett"})
      {:ok, query_data} = result
      author = get_in(query_data, [:data, "author"])
      assert author["name"] == "Terry Pratchett"
      assert author["slug"] == "terry-pratchett"
    end
  end
end
