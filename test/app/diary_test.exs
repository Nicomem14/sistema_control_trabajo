defmodule App.DiaryTest do
  use App.DataCase

  alias App.Diary

  describe "jobs" do
    alias App.Diary.Job

    import App.DiaryFixtures

    @invalid_attrs %{hours_worked: nil, work_description: nil, working_day: nil}

    test "list_jobs/0 returns all jobs" do
      job = job_fixture()
      assert Diary.list_jobs() == [job]
    end

    test "get_job!/1 returns the job with given id" do
      job = job_fixture()
      assert Diary.get_job!(job.id) == job
    end

    test "create_job/1 with valid data creates a job" do
      valid_attrs = %{hours_worked: "120.5", work_description: "some work_description", working_day: ~D[2022-11-20]}

      assert {:ok, %Job{} = job} = Diary.create_job(valid_attrs)
      assert job.hours_worked == Decimal.new("120.5")
      assert job.work_description == "some work_description"
      assert job.working_day == ~D[2022-11-20]
    end

    test "create_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diary.create_job(@invalid_attrs)
    end

    test "update_job/2 with valid data updates the job" do
      job = job_fixture()
      update_attrs = %{hours_worked: "456.7", work_description: "some updated work_description", working_day: ~D[2022-11-21]}

      assert {:ok, %Job{} = job} = Diary.update_job(job, update_attrs)
      assert job.hours_worked == Decimal.new("456.7")
      assert job.work_description == "some updated work_description"
      assert job.working_day == ~D[2022-11-21]
    end

    test "update_job/2 with invalid data returns error changeset" do
      job = job_fixture()
      assert {:error, %Ecto.Changeset{}} = Diary.update_job(job, @invalid_attrs)
      assert job == Diary.get_job!(job.id)
    end

    test "delete_job/1 deletes the job" do
      job = job_fixture()
      assert {:ok, %Job{}} = Diary.delete_job(job)
      assert_raise Ecto.NoResultsError, fn -> Diary.get_job!(job.id) end
    end

    test "change_job/1 returns a job changeset" do
      job = job_fixture()
      assert %Ecto.Changeset{} = Diary.change_job(job)
    end
  end
end
