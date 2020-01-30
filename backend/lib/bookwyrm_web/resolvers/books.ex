defmodule BookwyrmWeb.Resolvers.Books do
  @moduledoc """
  This module contains all of our Absinthe resolvers for our Books schema.
  """

  alias Bookwyrm.Books
  alias Bookwyrm.Accounts
  alias Bookwyrm.Web.Schema.ChangesetErrors

  def book(_, %{slug: slug}, _) do
    {:ok, Books.get_book_by_slug!(slug)}
  end

  def books(_, args, _) do
    {:ok, Books.list_books(args)}
  end

  def author(_, %{slug: slug}, _) do
    {:ok, Books.get_author_by_slug!(slug)}
  end

  def authors(_, args, _) do
    {:ok, Books.list_authors(args)}
  end

  def user(_, %{id: id}, _) do
    {:ok, Accounts.get_user(id)}
  end

  def users(_, %{book: book}, _) do
    {:ok, Books.list_users(book)}
  end

  def add_book(_, args, %{context: %{current_user: user}}) do
    case Books.add_book(
           user,
           %{title: args.title, description: args.description, isbn13: args.isbn13},
           %{name: args.author_name}
         ) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not add book!", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, book} ->
        {:ok, book}
    end
  end
end
