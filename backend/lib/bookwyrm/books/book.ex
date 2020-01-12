defmodule Bookwyrm.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "books" do
    field(:title, :string)
    field(:description, :string)
    field(:isbn13, :integer)
    field(:slug, :string)

    many_to_many(:users, Bookwyrm.Accounts.User, join_through: "users_books")
    many_to_many(:authors, Bookwyrm.Books.Author, join_through: "authors_books")
    has_many(:reviews, Bookwyrm.Books.Review)

    timestamps()
  end

  def changeset(book, attrs) do
    required_fields = [:title, :description, :isbn13, :slug]
    optional_fields = []

    book
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> put_assoc(:authors, attrs.authors)
    |> put_assoc(:users, attrs.users)
  end
end
