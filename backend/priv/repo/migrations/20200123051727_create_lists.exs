defmodule Bookwyrm.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add(:name, :string, null: false)
      add(:slug, :string, null: false)
      add(:user_id, references(:users), null: false)

      timestamps()
    end

    create table(:lists_books) do
      add(:list_id, references(:lists, on_delete: :delete_all), primary_key: true)
      add(:book_id, references(:books, on_delete: :delete_all), primary_key: true)
    end

    create(index(:lists_books, [:list_id]))
    create(index(:lists_books, [:book_id]))

    create(unique_index(:lists_books, [:list_id, :book_id], name: :list_id_book_id_unique_index))
  end
end
