defmodule BookwyrmWeb.Schema.Schema do
  use Absinthe.Schema
  alias Bookwyrm.{Accounts, Books}

  query do
    @desc "Get a book by its slug"
    field :book, :book do
      arg(:slug, non_null(:string))

      resolve(fn _, %{slug: slug}, _ ->
        {:ok, Books.get_book_by_slug!(slug)}
      end)
    end

    @desc "Get a list of books"
    field :books, list_of(:book) do
      arg(:limit, :integer)
      arg(:order, type: :sort_order, default_value: :asc)

      resolve(fn _, args, _ ->
        {:ok, Books.list_books(args)}
      end)
    end
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  object :book do
    field(:id, non_null(:id))
    field(:title, non_null(:string))
    field(:description, non_null(:string))
    field(:isbn13, non_null(:integer))
    field(:slug, non_null(:string))
  end
end
