defmodule ProductAnalysis.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :user_id, :string
      add :event_time, :naive_datetime
      add :event_name, :string
      add :attributes, :map
    end
  end
end
