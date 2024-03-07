defmodule ProductAnalysisWeb.EventsController do
  use ProductAnalysisWeb, :controller

  alias ProductAnalysis.Entries
  # alias ProductAnalysis.Entries.Events

  def create(conn, %{"event" => event_params}) do
    case Entries.create_event(event_params) do
      {:ok, _} -> conn |> send_resp(201, "Created")
      {:error, _} -> IO.puts("Not inserted")
    end
  end

  def get_user_analytics(conn, _) do
    list = Entries.get_user_analytics(conn.query_params)
    {:ok, resp} = Jason.encode(list)
    conn |> send_resp(200, resp) |> put_resp_content_type("application/json")
  end
end
