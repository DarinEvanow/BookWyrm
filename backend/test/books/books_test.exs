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
      assert length(Books.list_authors()) == 2
    end
  end

  describe "create_author/1" do
    test "creates an author with the correct information" do
      {:ok, author} =
        Books.create_author(%{
          first_name: "Frank",
          last_name: "Herbert",
          slug: "frank-herbert"
        })

      assert author.first_name == "Frank"
      assert author.last_name == "Herbert"
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
        Books.create_book(%{
          title: "Testing",
          description: "A book for testing",
          isbn13: 1_234_567_890_123,
          slug: "testing",
          authors: [author]
        })

      assert book.title == "Testing"
      assert book.description == "A book for testing"
      assert book.isbn13 == 1_234_567_890_123
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

  describe "create_review" do
    test "creates a review that is related to the given author and user" do
      user = user_fixture()
      author = author_fixture()
      book = book_fixture(author)

      {:ok, review} = Books.create_review(user, book, %{review: "So good.", rating: 5})
      assert review.user == user
      assert review.book == book
    end
  end
end
