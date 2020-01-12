defmodule BookwyrmWeb.Resolvers.Books do
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
end
