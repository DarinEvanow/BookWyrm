defmodule BookwyrmWeb.Test.Schema.GetUsersLists do
  use Bookwyrm.DataCase, async: true
  use Wormwood.GQLCase
  alias Bookwyrm.Repo
  alias Bookwyrm.Accounts.User

  load_gql(BookwyrmWeb.Schema.Schema, "test/support/queries/GetUsersLists.gql")

  describe "GetUsersLists.gql" do
    test "should return all of Marinas book lists" do
      marina = Repo.get_by(User, username: "marina")

      result =
        query_gql(
          variables: %{},
          context: %{
            :current_user => marina,
            :token =>
              "SFMyNTY.g3QAAAACZAAEZGF0YXQAAAABZAACaWRhA2QABnNpZ25lZG4GAIOMyw5wAQ.vJOpspU28A-OgGWV1W7UgQzJnoa-UbDn70pOf4CFiAM"
          }
        )

      {:ok, query_data} = result
      lists = get_in(query_data, [:data, "lists"])
      favorite_books = Enum.filter(lists, &(&1["name"] == "Favorite Books"))
      IO.inspect(favorite_books)
      assert List.first(favorite_books)["slug"] == "favorite-books"
    end
  end
end
