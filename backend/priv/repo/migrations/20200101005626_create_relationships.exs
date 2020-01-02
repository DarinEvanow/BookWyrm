defmodule Bookwyrm.Repo.Migrations.CreateRelationships do
  use Ecto.Migration

  def change do
    create table(:users_books) do
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
      add(:book_id, references(:books, on_delete: :delete_all), primary_key: true)
    end

    create(index(:users_books, [:user_id]))
    create(index(:users_books, [:book_id]))

    create(unique_index(:users_books, [:user_id, :book_id], name: :user_id_book_id_unique_index))

    create table(:authors_books) do
      add(:author_id, references(:authors, on_delete: :delete_all), primary_key: true)
      add(:book_id, references(:books, on_delete: :delete_all), primary_key: true)
    end

    create(index(:authors_books, [:author_id]))
    create(index(:authors_books, [:book_id]))

    create(
      unique_index(:authors_books, [:author_id, :book_id], name: :author_id_book_id_unique_index)
    )
  end
end
