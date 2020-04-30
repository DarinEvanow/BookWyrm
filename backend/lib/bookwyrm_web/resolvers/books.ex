defmodule BookwyrmWeb.Resolvers.Books do
  @moduledoc """
  This module contains all of our Absinthe resolvers for our Books schema.
  """

  alias Bookwyrm.Repo
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

  def list(_, %{id: id}, _) do
    {:ok, Books.get_list!(id)}
  end

  def lists(_, _, %{context: %{current_user: user}}) do
    {:ok, Books.get_lists(user)}
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

  def add_list(_, args, %{context: %{current_user: user}}) do
    case Books.add_list(user, %{name: args.name}) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not add list!", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, list} ->
        {:ok, list}
    end
  end

  def add_book_to_list(_, args, %{context: %{current_user: user}}) do
    case Books.add_book_to_list(user, args.list_id, args.book_slug) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not add book to list!",
          details: ChangesetErrors.error_details(changeset)
        }

      {:ok, list} ->
        {:ok, list}
    end
  end
end
