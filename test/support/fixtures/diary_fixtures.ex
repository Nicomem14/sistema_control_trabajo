defmodule App.DiaryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Diary` context.
  """

  @doc """
  Generate a job.
  """
  def job_fixture(attrs \\ %{}) do
    {:ok, job} =
      attrs
      |> Enum.into(%{
        hours_worked: "120.5",
        work_description: "some work_description",
        working_day: ~D[2022-11-20]
      })
      |> App.Diary.create_job()

    job
  end
end
