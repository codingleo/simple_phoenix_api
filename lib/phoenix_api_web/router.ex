defmodule PhoenixApiWeb.Router do
  use PhoenixApiWeb, :router
  import Plug.BasicAuth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug :basic_auth, Application.compile_env(:phoenix_api, :basic_auth)
  end

  scope "/api", PhoenixApiWeb do
    pipe_through :api

    get "/:filename", WelcomeController, :index
  end

  scope "/api", PhoenixApiWeb do
    pipe_through [:api, :auth]

    post "/accounts/:id/deposit", AccountController, :deposit
    post "/accounts/:id/withdraw", AccountController, :withdraw
    post "/accounts/transaction", AccountController, :transaction
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PhoenixApiWeb.Telemetry
    end
  end
end
