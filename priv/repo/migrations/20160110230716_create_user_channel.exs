defmodule Furby.Repo.Migrations.CreateUserChannel do
  use Ecto.Migration

  def change do
    create table(:user_channels) do
      add :user_id, :integer
      add :channel_id, :integer
    end

  end
end
