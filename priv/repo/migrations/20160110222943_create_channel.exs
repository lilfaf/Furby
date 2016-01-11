defmodule Furby.Repo.Migrations.CreateChannel do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :slack_id, :string
      add :created, :integer
      add :creator, :string
      add :is_archived, :boolean, default: false
      add :is_channel, :boolean, default: false
      add :is_general, :boolean, default: false
      add :is_member, :boolean, default: false
      add :members, {:array, :string}
      add :name, :string
      add :num_members, :integer

      timestamps
    end

  end
end
