defmodule BookwyrmWeb.Router do
  use BookwyrmWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(BookwyrmWeb.Plugs.SetCurrentUser)
  end

  scope "/" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug, schema: BookwyrmWeb.Schema.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: BookwyrmWeb.Schema.Schema,
      socket: BookwyrmWeb.UserSocket
    )
  end
end
