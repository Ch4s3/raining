defmodule Raining.Repo do
  use Ecto.Repo,
    otp_app: :raining,
    adapter: Ecto.Adapters.Postgres
end
