defmodule Bookwyrm.TestHelpers do
  alias Bookwyrm.Repo

  alias Bookwyrm.Books.{Author, Book, Review}
  alias Bookwyrm.Accounts.User

  def user(username) do
    Bookwyrm.Repo.get_by!(User, username: username)
  end

  def author(slug) do
    Bookwyrm.Repo.get_by!(Author, slug: slug)
  end

  def book(title) do
    Bookwyrm.Repo.get_by!(Book, title: title)
  end

  def review(id) do
    Bookwyrm.Repo.get_by!(Review, id)
  end

  def user_fixture(attrs \\ %{}) do
    username = "user-#{System.unique_integer([:positive])}"

    attrs =
      Enum.into(attrs, %{
        username: "test-user",
        email: attrs[:email] || "#{username}@example.com",
        password: attrs[:password] || "supersecret",
        books: []
      })

    {:ok, user} =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    user
  end

  def author_fixture(attrs \\ %{}, books \\ []) do
    first_name = "first_name-#{System.unique_integer([:positive])}"
    last_name = "last_name-#{System.unique_integer([:positive])}"
    slug = "slug-#{System.unique_integer([:positive])}"

    attrs =
      Enum.into(attrs, %{
        first_name: attrs[:first_name] || first_name,
        last_name: attrs[:last_name] || last_name,
        slug: attrs[:slug] || slug,
        books: books
      })

    {:ok, author} =
      %Author{}
      |> Author.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:books, books)
      |> Repo.insert()

    author
  end

  def book_fixture(author \\ %Author{}, attrs \\ %{}) do
    title = "title-#{System.unique_integer([:positive])}"
    description = "description-#{System.unique_integer([:positive])}"
    slug = "slug-#{System.unique_integer([:positive])}"
    isbn13 = 1_234_567_890_123

    attrs =
      Enum.into(attrs, %{
        title: attrs[:title] || title,
        description: attrs[:description] || description,
        isbn13: attrs[:isbn13] || isbn13,
        slug: attrs[:slug] || slug,
        authors: [author]
      })

    {:ok, book} =
      %Book{}
      |> Book.changeset(attrs)
      |> Repo.insert()

    book
  end

  def review_fixture(attrs \\ %{}, user \\ %User{}, book \\ %Book{}) do
    review = "review-#{System.unique_integer([:positive])}"
    rating = Enum.random(0..5)

    attrs =
      Enum.into(attrs, %{
        review: attrs[:review] || review,
        rating: attrs[:rating] || rating
      })

    {:ok, review} =
      %Review{}
      |> Review.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:user, user)
      |> Ecto.Changeset.put_assoc(:book, book)
      |> Repo.insert()

    review
  end
end
