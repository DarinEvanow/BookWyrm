defmodule Bookwyrm.Books.List do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "lists" do
    field(:name, :string)
    field(:slug, :string)

    belongs_to(:user, Bookwyrm.Accounts.User)
    many_to_many(:books, Bookwyrm.Books.Book, join_through: "lists_books")

    timestamps()
  end

  def changeset(list, attrs) do
    required_fields = [:name]
    optional_fields = []

    list
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> add_slug()
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
