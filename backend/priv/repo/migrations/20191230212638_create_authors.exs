defmodule Bookwyrm.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add(:name, :string, null: false)
      add(:slug, :string, null: false)

      timestamps()
    end

    create(unique_index(:authors, [:slug]))
  end
end
