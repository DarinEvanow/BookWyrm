defmodule Bookwyrm.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add(:review, :string, null: false)
      add(:rating, :integer, null: false)
      add(:book_id, references(:books), null: false)
      add(:user_id, references(:users), null: false)

      timestamps()
    end

    create index(:reviews, [:book_id, :user_id])
  end
end
