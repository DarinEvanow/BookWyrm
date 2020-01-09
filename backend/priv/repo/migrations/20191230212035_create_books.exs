defmodule Bookwyrm.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add(:title, :string, null: false)
      add(:description, :string, null: false)
      add(:isbn13, :bigint, null: false)
      add(:slug, :string, null: false)

      timestamps()
    end

    create unique_index(:books, [:isbn13])
    create unique_index(:books, [:slug])
  end
end
