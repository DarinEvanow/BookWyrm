defmodule BookwyrmWeb.Test.Schema.AddBook do
  use Bookwyrm.DataCase, async: true
  use Wormwood.GQLCase
  alias Bookwyrm.Repo
  alias Bookwyrm.Accounts.User

  load_gql(BookwyrmWeb.Schema.Schema, "test/support/queries/AddBook.gql")

  describe "AddBook.gql" do
    test "should add a book to Marinas lists of books" do
      marina = Repo.get_by(User, username: "marina")

      result =
        query_gql(
          variables: %{
            "title" => "Thinking Fast and Slow",
            "description" =>
              "A groundbreaking tour of the mind and explains the two systems that drive the way we think",
            "isbn13" => 9_780_141_033_570,
            "authorName" => "Daniel Kahneman"
          },
          context: %{
            :current_user => marina,
            :token =>
              "SFMyNTY.g3QAAAACZAAEZGF0YXQAAAABZAACaWRhA2QABnNpZ25lZG4GAIOMyw5wAQ.vJOpspU28A-OgGWV1W7UgQzJnoa-UbDn70pOf4CFiAM"
          }
        )

      {:ok, query_data} = result
      book = get_in(query_data, [:data, "addBook"])
      assert book["title"] == "Thinking Fast and Slow"

      assert book["description"] ==
               "A groundbreaking tour of the mind and explains the two systems that drive the way we think"

      assert book["isbn13"] == 9_780_141_033_570
      assert Enum.member?(book["authors"], %{"name" => "Daniel Kahneman"})
    end
  end
end
