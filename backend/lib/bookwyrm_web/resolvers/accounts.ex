defmodule BookwyrmWeb.Resolvers.Accounts do
  @moduledoc """
  This module contains all of our Absinthe resolvers for our Accounts schema. This functionality
  includes signing up, signing in, and getting information about the current user.
  """

  alias Bookwyrm.Accounts
  alias Bookwyrm.Web.Schema.ChangesetErrors

  def signup(_, args, _) do
    case Accounts.create_user(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create account!", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, user} ->
        token = BookwyrmWeb.AuthToken.sign(user)
        {:ok, %{user: user, token: token}}
    end
  end

  def signin(_, %{email: email, password: password}, _) do
    case Accounts.authenticate(email, password) do
      :error ->
        {:error, "Invalid credentials!"}

      {:ok, user} ->
        token = BookwyrmWeb.AuthToken.sign(user)
        {:ok, %{user: user, token: token}}
    end
  end

  def me(_, _, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def me(_, _, _) do
    {:ok, nil}
  end
end
