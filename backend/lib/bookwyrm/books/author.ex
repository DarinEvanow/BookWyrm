defmodule Bookwyrm.Books.Author do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "authors" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:slug, :string)

    many_to_many(:books, Bookwyrm.Books.Book, join_through: "authors_books")

    timestamps()
  end

  def changeset(author, attrs) do
    required_fields = [:first_name, :last_name, :slug]
    optional_fields = []

    author
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> put_assoc(:books, attrs.books)
  end
end
