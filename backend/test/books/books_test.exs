defmodule Bookwyrm.BooksTest do
  use Bookwyrm.DataCase, async: true

  alias Bookwyrm.Books

  describe "get_author_by_slug!/1" do
    test "returns the author with the given slug" do
      author = author_fixture()
      assert Books.get_author_by_slug!(author.slug) == author
    end
  end

  describe "list_authors/1" do
    test "returns all of the authors" do
      _author_one = author_fixture()
      _author_two = author_fixture()
      assert length(Books.list_authors(%{})) == 6
    end
  end

  describe "create_author/1" do
    test "creates an author with the correct information" do
      {:ok, author} =
        Books.create_author(%{
          name: "Frank Herbert"
        })

      assert author.name == "Frank Herbert"
      assert author.slug == "frank-herbert"
    end
  end

  describe "get_book_by_slug/1" do
    test "returns the book with the given slug" do
      author = author_fixture()
      book = book_fixture(author)
      assert Books.get_book_by_slug!(book.slug).isbn13 == book.isbn13
    end
  end

  describe "create_book/2" do
    test "creates a book that is related to the given author" do
      author = author_fixture()

      {:ok, book} =
        Books.create_book(
          %{
            title: "Testing",
            description: "A book for testing",
            isbn13: 1_234_567_890_100,
            slug: "testing"
          },
          [author]
        )

      assert book.title == "Testing"
      assert book.description == "A book for testing"
      assert book.isbn13 == 1_234_567_890_100
      assert book.slug == "testing"
      assert book.authors == [author]
    end
  end

  describe "get_review!/1" do
    test "returns the review with the given id" do
      user = user_fixture()
      author = author_fixture()
      book = book_fixture(author)

      review = review_fixture(%{}, user, book)
      assert Books.get_review!(review.id).id == review.id
    end
  end

  describe "create_review/3" do
    test "creates a review that is related to the given author and user" do
      user = user_fixture()
      author = author_fixture()
      book = book_fixture(author)

      {:ok, review} = Books.create_review(user, book, %{review: "So good.", rating: 5})
      assert review.user == user
      assert review.book == book
    end
  end

  describe "add_book/2" do
    test "creates a book and author, then associates the book to the given user" do
      user = user_fixture()

      book = %{
        title: "Mort",
        description: "A book about death.",
        isbn13: 9_780_575_041_714
      }

      author = %{
        name: "Terry Pratchett"
      }

      {:ok, mort} = Books.add_book(user, book, author)

      user = Repo.preload(user, :books)

      assert Enum.member?(Enum.map(mort.users, & &1.id), user.id)
    end
  end

  describe "add_list/2" do
    test "adds a list to a users set of lists" do
      user = user_fixture()

      list = %{
        name: "Favorite Books"
      }

      {:ok, favorite_books} = Books.add_list(user, list)
      user = Repo.preload(user, :lists)

      assert Enum.member?(Enum.map(user.lists, & &1.name), list.name)
    end
  end

  describe "add_book_to_list/3" do
    test "adds a book to the users list" do
      user = user_fixture()

      book = %{
        title: "Mort",
        description: "A book about death.",
        isbn13: 9_780_575_041_715
      }

      author = %{
        name: "Terry Pratchett"
      }

      list = %{
        name: "Favorite Books"
      }

      {:ok, favorite_books} = Books.add_list(user, list)
      {:ok, mort} = Books.add_book(user, book, author)
      {:ok, favorite_books} = Books.add_book_to_list(user, favorite_books.id, mort.slug)

      assert Enum.member?(Enum.map(favorite_books.books, & &1.title), mort.title)
    end
  end
end
