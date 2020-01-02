defmodule Bookwyrm.Books.Review do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "reviews" do
    field(:review, :string)
    field(:rating, :integer)

    belongs_to(:book, Bookwyrm.Books.Book)
    belongs_to(:user, Bookwyrm.Accounts.User)

    timestamps()
  end

  def changeset(review, attrs) do
    required_fields = [:review, :rating]
    optional_fields = []

    review
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> assoc_constraint(:books)
    |> assoc_constraint(:users)
  end
end
