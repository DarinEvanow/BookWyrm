defmodule BookwyrmWeb.Schema.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  alias Bookwyrm.{Accounts, Books}
  alias BookwyrmWeb.Resolvers

  query do
    @desc "Get a book by its slug"
    field :book, :book do
      arg(:slug, non_null(:string))

      resolve(&Resolvers.Books.book/3)
    end

    @desc "Get a list of books"
    field :books, list_of(:book) do
      arg(:limit, :integer)
      arg(:order, type: :sort_order, default_value: :asc)

      resolve(&Resolvers.Books.books/3)
    end

    @desc "Get an author by their slug"
    field :author, :author do
      arg(:slug, non_null(:string))

      resolve(&Resolvers.Books.author/3)
    end

    @desc "Get a list of authors"
    field :authors, list_of(:author) do
      arg(:limit, :integer)
      arg(:order, type: :sort_order, default_value: :asc)

      resolve(&Resolvers.Books.authors/3)
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

    field(:authors, list_of(:author), resolve: dataloader(Books))
  end

  object :author do
    field(:id, non_null(:id))
    field(:first_name, non_null(:string))
    field(:last_name, non_null(:string))
    field(:slug, non_null(:string))
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Books, Books.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
