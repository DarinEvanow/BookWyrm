defmodule BookwyrmWeb.Schema.Middleware.Authenticate do
  @moduledoc """
  This module contains the middleware that allows us to check for authentication
  in our GraphQL queries. By adding in the Middleware before the call to the resolver,
  the query will not be executed and instead the user will be prompted to sign in.

  Example:
  query do
    @desc "Add a book to the current users list of books"
    field :add_book, :book do
      arg(:title, non_null(:string))
      arg(:description, non_null(:string))
      arg(:isbn13, non_null(:integer))
      arg(:author_name, non_null(:string))

      middleware(Middleware.Authenticate)
      resolve(&Resolvers.Books.add_book/3)
    end
  end
  """

  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    case resolution.context do
      %{current_user: _} ->
        resolution

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "Please sign in first!"})
    end
  end
end
