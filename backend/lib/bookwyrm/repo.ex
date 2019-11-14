defmodule Bookwyrm.Repo do
  use Ecto.Repo,
    otp_app: :bookwyrm,
    adapter: Ecto.Adapters.Postgres
end
