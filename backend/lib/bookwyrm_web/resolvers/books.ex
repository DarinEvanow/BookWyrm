defmodule BookwyrmWeb.Resolvers.Books do
  alias Bookwyrm.Books
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
end
