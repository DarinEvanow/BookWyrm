defmodule Bookwyrm.Books.Book do
  @moduledoc """
  This module contains the schema for books.
  """

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
    many_to_many(:lists, Bookwyrm.Books.List, join_through: "lists_books")
    has_many(:reviews, Bookwyrm.Books.Review)

    timestamps()
  end

  def changeset(book, attrs) do
    required_fields = [:title, :description, :isbn13]
    optional_fields = []

    book
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> add_slug()
    |> unique_constraint(:isbn13)
    |> unique_constraint(:slug)
    |> put_assoc(:authors, attrs.authors)
  end

  defp add_slug(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{title: title}} ->
        put_change(changeset, :slug, Slugger.slugify_downcase(title))

      _ ->
        changeset
    end
  end
end
