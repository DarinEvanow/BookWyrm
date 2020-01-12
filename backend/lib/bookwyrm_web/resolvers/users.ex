defmodule BookwyrmWeb.Resolvers.Users do
  alias Bookwyrm.Users
  alias Bookwyrm.Web.Schema.ChangesetErrors

  def user(_, %{id: id}, _) do
    {:ok, Accounts.get_user(id)}
  end
end
