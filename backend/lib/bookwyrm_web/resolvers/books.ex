defmodule BookwyrmWeb.Resolvers.Books do
  alias Bookwyrm.Books
  alias Bookwyrm.Web.Schema.ChangesetErrors

  def book(_, %{slug: slug}, _) do
    {:ok, Books.get_book_by_slug!(slug)}
  end

  def books(_, args, _) do
    {:ok, Books.list_books(args)}
  end

  def authors_for_book(book, _, _) do
    {:ok, Books.authors_for_book(book)}
  end
end
