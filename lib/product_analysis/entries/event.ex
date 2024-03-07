defmodule ProductAnalysis.Entries.Event do
  use Ecto.Schema

  import Ecto.Changeset

  schema "events" do
    field :user_id, :string
    field :event_time, :naive_datetime
    field :event_name, :string
    field :attributes, :map, default: %{}
  end

  def changeset(event, params \\ %{}) do
    event
    |> cast(params, [:user_id, :event_time, :event_name])
    |> validate_required([:user_id, :event_name])
  end
end
