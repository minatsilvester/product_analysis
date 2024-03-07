defmodule ProductAnalysis.Repo do
  use Ecto.Repo,
    otp_app: :product_analysis,
    adapter: Ecto.Adapters.Postgres
end
