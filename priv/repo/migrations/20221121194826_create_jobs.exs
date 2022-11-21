defmodule App.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :working_day, :date
      add :hours_worked, :decimal
      add :work_description, :text

      timestamps()
    end
  end
end
