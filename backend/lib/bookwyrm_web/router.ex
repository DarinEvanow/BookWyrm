defmodule BookwyrmWeb.Router do
  use BookwyrmWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BookwyrmWeb do
    pipe_through :api
  end
end
