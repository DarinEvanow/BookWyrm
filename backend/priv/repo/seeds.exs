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
alias Bookwyrm.Books.{Author, Book, List, Review}
alias Bookwyrm.Accounts.User

darin =
  %User{}
  |> User.changeset(%{
    username: "darin",
    email: "darin@example.com",
    password: "secret"
  })
  |> Repo.insert!()

marina =
  %User{}
  |> User.changeset(%{
    username: "marina",
    email: "marina@example.com",
    password: "secret"
  })
  |> Repo.insert!()

rothfuss =
  %Author{}
  |> Author.changeset(%{
    name: "Patrick Rothfuss",
    books: []
  })
  |> Repo.insert!()

name_of_the_wind =
  %Book{}
  |> Book.changeset(%{
    title: "The Name of the Wind",
    description: "The Name of the Wind is a heroic fantasy novel.",
    isbn13: 9_780_756_404_079,
    slug: "the-name-of-the-wind",
    authors: [
      rothfuss
    ],
    users: [
      darin,
      marina
    ],
    reviews: [
      %Review{
        review: "Very good.",
        rating: 5,
        user: darin
      },
      %Review{
        review: "I like.",
        rating: 5,
        user: marina
      }
    ]
  })
  |> Repo.insert!()

wise_mans_fear =
  %Book{}
  |> Book.changeset(%{
    title: "The Wise Man's Fear",
    description: "The Wise Man's Fear is a heroic fantasy novel.",
    isbn13: 9_780_756_404_734,
    authors: [
      rothfuss
    ],
    users: [
      darin,
      marina
    ],
    reviews: [
      %Review{
        review: "Even better than the first.",
        rating: 5,
        user: darin
      },
      %Review{
        review: "I like. Hope the third one comes out soon!",
        rating: 5,
        user: marina
      }
    ]
  })
  |> Repo.insert!()

asimov =
  %Author{}
  |> Author.changeset(%{
    name: "Isaac Asimov",
    books: []
  })
  |> Repo.insert!()

foundation =
  %Book{}
  |> Book.changeset(%{
    title: "Foundation",
    description: "The first book in the Foundation Series.",
    isbn13: 1_234_567_890_123,
    authors: [
      asimov
    ],
    users: [
      darin
    ],
    reviews: [
      %Review{
        review: "Good.",
        rating: 5,
        user: darin
      }
    ]
  })
  |> Repo.insert!()

foundation_and_empire =
  %Book{}
  |> Book.changeset(%{
    title: "Foundation and Empire",
    description: "The second book in the Foundation Series.",
    isbn13: 2_234_567_890_123,
    authors: [
      asimov
    ],
    users: [
      darin
    ],
    reviews: [
      %Review{
        review: "Gooder.",
        rating: 5,
        user: darin
      }
    ]
  })
  |> Repo.insert!()

second_foundation =
  %Book{}
  |> Book.changeset(%{
    title: "Second Foundation",
    description: "The third book in the Foundation Series.",
    isbn13: 3_234_567_890_123,
    authors: [
      asimov
    ],
    users: [
      darin
    ],
    reviews: [
      %Review{
        review: "Even better than the first.",
        rating: 5,
        user: darin
      }
    ]
  })
  |> Repo.insert!()

gaiman =
  %Author{}
  |> Author.changeset(%{
    name: "Neil Gaiman",
    books: []
  })
  |> Repo.insert!()

pratchett =
  %Author{}
  |> Author.changeset(%{
    name: "Terry Pratchett",
    books: []
  })
  |> Repo.insert!()

good_omens =
  %Book{}
  |> Book.changeset(%{
    title: "Good Omens",
    description: "A book about the birth of the son of Satan and the coming of the End Times.",
    isbn13: 4_234_567_890_123,
    authors: [
      gaiman,
      pratchett
    ],
    users: [
      darin
    ],
    reviews: [
      %Review{
        review: "Laughed so hard I felt close to God.",
        rating: 5,
        user: darin
      }
    ]
  })
  |> Repo.insert!()

marina_list =
  %List{}
  |> List.changeset(%{
    name: "Favorite Books"
  })
  |> Ecto.Changeset.put_assoc(:user, marina)
  |> Ecto.Changeset.put_assoc(:books, [good_omens])
  |> Repo.insert()
