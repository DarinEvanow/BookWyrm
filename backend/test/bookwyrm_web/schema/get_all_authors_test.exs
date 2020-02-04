defmodule BookwyrmWeb.Test.Schema.GetAllAuthorsTest do
  use Bookwyrm.DataCase, async: true
  use Wormwood.GQLCase

  load_gql(BookwyrmWeb.Schema.Schema, "test/support/queries/GetAllAuthors.gql")

  describe "GetAllAuthors.gql" do
    test "should return all 4 authors" do
      result = query_gql()
      {:ok, query_data} = result
      assert length(get_in(query_data, [:data, "authors"])) == 4
    end
  end
end
