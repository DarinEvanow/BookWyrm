defmodule BookwyrmWeb.Test.Schema.GetAllBooksTest do
  use Bookwyrm.DataCase, async: true
  use Wormwood.GQLCase

  load_gql(BookwyrmWeb.Schema.Schema, "test/support/queries/GetAllBooks.gql")

  describe "GetAllBooks.gql" do
    test "should return all 6 books" do
      result = query_gql()
      {:ok, query_data} = result
      assert length(get_in(query_data, [:data, "books"])) == 6
    end
  end
end
