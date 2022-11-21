defmodule App.Diary.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :hours_worked, :decimal
    field :work_description, :string
    field :working_day, :date

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:working_day, :hours_worked, :work_description])
    |> validate_required([:working_day, :hours_worked, :work_description])
  end
end
