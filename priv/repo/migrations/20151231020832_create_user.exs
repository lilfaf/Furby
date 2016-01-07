defmodule Furby.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :nickname, :string
      add :image, :string
      add :access_token, :string

      timestamps
    end

  end
end
