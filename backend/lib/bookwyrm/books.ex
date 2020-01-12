defmodule Bookwyrm.Books do
  @moduledoc """
  The Books context: public interface for creating books, authors, and reviews
  """

  import Ecto.Query, warn: false
  alias Bookwyrm.Repo

  alias Bookwyrm.Books.{Author, Book, Review}
  alias Bookwyrm.Accounts.User

  @doc """
  Returns the author with the given `slug`.

  Raises `Ecto.NoResultsError` if no place was found.
  """
  def get_author_by_slug!(slug) do
    Author
    |> Repo.get_by!(slug: slug)
    |> Repo.preload(:books)
  end

  @doc """
  Returns a list of all authors.
  """
  def list_authors do
    Repo.all(Author)
  end

  @doc """
  Creates an author.
  """
  def create_author(attrs) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the book with the given `slug`.

  Raises `Ecto.NoResultsError` if no place was found.
  """
  def get_book_by_slug!(slug) do
    Repo.get_by!(Book, slug: slug)
  end

  @doc """
  Returns a list of all books matching the given `criteria.

  Example Criteria:
  [{:limit, 15}, {:order, :asc}]
  """
  def list_books(criteria) do
    query = from(b in Book)

    Enum.reduce(criteria, query, fn
      {:limit, limit}, query ->
        from(b in query, limit: ^limit)

      {:order, order}, query ->
        from(b in query, order_by: [{^order, :id}])
    end)
    |> Repo.all()
  end

  @doc """
  Creates a book associated with the given list of authors.
  """
  def create_book(attrs) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the review with the given `id`.

  Raises `Ecto.NoResultsError` if no booking was found.
  """
  def get_review!(id) do
    Repo.get!(Review, id)
  end

  @doc """
  Creates a review for the given user and book.
  """
  def create_review(%User{} = user, %Book{} = book, attrs) do
    %Review{}
    |> Review.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:book, book)
    |> Repo.insert()
  end
end
