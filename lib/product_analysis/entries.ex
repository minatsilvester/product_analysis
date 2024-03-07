defmodule ProductAnalysis.Entries do
  import Ecto.Query

  alias ProductAnalysis.Repo

  alias ProductAnalysis.Entries.Event

  def create_event(attrs) do
   %Event{}
   |> Event.changeset(attrs)
   |> Repo.insert()
  end

  def get_user_analytics(query_params) do
    get_base_query(query_params) |> create_group_by_user_id() |> Repo.all()
    # get_base_query(query_params)
    # |> Repo.all()
    # |> IO.puts()
  end

  def get_event_analytics(query_params) do
    get_base_query_for_event_analytics(query_params)
    |> create_group_by_event_date()
    |> Repo.all()
    # |> IO.inspect()
  end

  def get_base_query_for_event_analytics(query_params) do
    Enum.reduce(query_params, Event, fn
      {"from", from} -> from(e in Event, where: e.event_time >= ^from)
      {"to", to} -> from(e in Event, where: e.event_time <= ^to)
      {"event_name", event_name} -> from(e in Event, where: e.event_name == ^event_name)
      _ -> Event
    end)
  end

  def create_group_by_user_id(query) do
    # from(q in query, group_by: q.user_id, select: {q.user_id, count(q.id)})
    from(q in query, group_by: q.user_id, select: %{user_id: q.user_id, count: count(q.id), last_event_time: max(q.event_time)})
  end

  def create_group_by_event_date(query) do
    from(q in query, group_by: q.event_time, select: %{date: q.event_time, count: count(q.id), unique_count: count(q.user_id, :distinct)})
  end

  def get_base_query(query_params) do
    case Map.get(query_params, "event_name", nil) do
      nil -> Event
      event -> from(e in Event, where: e.event_name == ^event)
    end
  end


end
