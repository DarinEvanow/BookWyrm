defmodule Bookwyrm.Books.Author do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "authors" do
    field(:name, :string)
    field(:slug, :string)

    many_to_many(:books, Bookwyrm.Books.Book, join_through: "authors_books")

    timestamps()
  end

  def changeset(author, attrs) do
    required_fields = [:name]
    optional_fields = []

    author
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> add_slug()
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end

  defp add_slug(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{name: name}} ->
        put_change(changeset, :slug, Slugger.slugify_downcase(name))

      _ ->
        changeset
    end
  end
end
