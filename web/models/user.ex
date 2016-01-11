defmodule Furby.User do
  use Furby.Web, :model

  schema "users" do
    has_many :user_channels, Furby.UserChannel
    has_many :channels, through: [:user_channels, :channels]

    field :email, :string
    field :name, :string
    field :nickname, :string
    field :image, :string
    field :access_token, :string

    timestamps
  end

  @required_fields ~w(email name nickname image access_token)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def from_ueberauth(%Ueberauth.Auth{} = auth) do
    user_params =
      auth.info
      |> Map.merge(%{access_token: auth.credentials.token})
      |> Map.from_struct

    case Furby.Repo.get_by(__MODULE__, email: auth.info.email) do
      nil -> %__MODULE__{}
      user -> user
    end
    |> Furby.User.changeset(user_params)
    |> Furby.Repo.insert_or_update
  end
end
