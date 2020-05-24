defmodule Bookwyrm.Books do
  @moduledoc """
  The Books context: public interface for creating books, authors, and reviews
  """

  import Ecto.Query, warn: false
  alias Bookwyrm.Repo

  alias Bookwyrm.Books.{Author, Book, List, Review}
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
  Returns a list of all authors that satisfy the given criteria.
  """
  def list_authors(criteria) do
    query = from(a in Author)

    Enum.reduce(criteria, query, fn
      {:limit, limit}, query ->
        from(a in query, limit: ^limit)

      {:order, order}, query ->
        from(a in query, order_by: [{^order, :id}])
    end)
    |> Repo.all()
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
  Returns a list of all books matching the given `criteria`.

  Example Criteria:
  [{:limit, 15}, {:order, :asc}]
  """
  def list_books(criteria) do
    query = from(b in Book, preload: [:authors])

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
  def create_book(book_attrs, authors) do
    %Book{}
    |> Book.changeset(book_attrs)
    |> Ecto.Changeset.put_assoc(:authors, authors)
    |> Repo.insert()
  end

  @doc """
  Add a book to the current users list of books.
  """
  def add_book(user, book_attrs, author_attrs) do
    author = get_or_insert_author(author_attrs)

    %Book{}
    |> Book.changeset(book_attrs)
    |> Ecto.Changeset.put_assoc(:authors, [author])
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.insert()
  end

  defp get_or_insert_author(attrs) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert!(on_conflict: [set: [name: attrs.name]], conflict_target: :name)
  end

  @doc """
  Returns the review with the given `id`.

  Raises `Ecto.NoResultsError` if no booking was found.
  """
  def get_review!(id) do
    Repo.get!(Review, id)
  end

  @doc """
  Returns the users that have read this book
  """
  def list_users(book) do
    book = Repo.preload(book, :users)
    book.users
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

  @doc """
  Returns the list with the given `id`.
  """
  def get_list!(id) do
    Repo.get!(List, id)
  end

  @doc """
  Returns all the lists of the given `user`.
  """
  def get_lists(user) do
    user =
      User
      |> Repo.get!(user.id)
      |> Repo.preload(:lists)

    user.lists
  end

  @doc """
  Creates a list for the given user.
  """
  def add_list(%User{} = user, attrs) do
    %List{}
    |> List.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Add a book to the given list.
  """
  def add_book_to_list(user, list_id, book_slug) do
    list = get_list!(list_id) |> Repo.preload(:books)
    book = get_book_by_slug!(book_slug)

    %List{}
    |> List.changeset(%{name: list.name})
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:books, [book])
    |> Repo.insert()
  end

  # Dataloader functionality

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
