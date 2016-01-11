defmodule Furby.Channel do
  use Furby.Web, :model

  schema "channels" do
    field :slack_id, :string
    field :created, :integer
    field :creator, :string
    field :is_archived, :boolean, default: false
    field :is_channel, :boolean, default: false
    field :is_general, :boolean, default: false
    field :is_member, :boolean, default: false
    field :members, {:array, :string}
    field :name, :string
    field :num_members, :integer

    timestamps
  end

  @required_fields ~w(slack_id created creator is_archived is_channel is_general is_member members name num_members)
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
end
