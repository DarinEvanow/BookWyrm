# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bookwyrm.Repo.insert!(%Bookwyrm.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Bookwyrm.Repo
alias Bookwyrm.Books.{Author, Book, Review}
alias Bookwyrm.Accounts.User

darin =
  %User{}
  |> User.changeset(%{
    username: "darin",
    email: "darin@example.com",
    password: "secret",
    books: []
  })
  |> Repo.insert!()

marina =
  %User{}
  |> User.changeset(%{
    username: "marina",
    email: "marina@example.com",
    password: "secret",
    books: []
  })
  |> Repo.insert!()

trashmen =
  %Author{}
  |> Author.changeset(%{
    first_name: "The",
    last_name: "Trashmen",
    slug: "the-trashmen",
    books: []
  })
  |> Repo.insert!()

book_one =
  %Book{}
  |> Book.changeset(%{
    title: "The Bird Book",
    description: "The bird is the word.",
    isbn_13: "1234567890123",
    slug: "the-bird-book",
    authors: [
      trashmen
    ],
    users: [
      darin,
      marina
    ],
    reviews: [
      %Review{
        review: "I have never felt so close to God.",
        rating: 5,
        user: darin
      },
      %Review{
        review: "I hate this because I am a heathen.",
        rating: 0,
        user: marina
      }
    ]
  })
  |> Repo.insert!()
