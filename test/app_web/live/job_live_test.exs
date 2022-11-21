defmodule AppWeb.JobLiveTest do
  use AppWeb.ConnCase

  import Phoenix.LiveViewTest
  import App.DiaryFixtures

  @create_attrs %{hours_worked: "120.5", work_description: "some work_description", working_day: "2022-11-20"}
  @update_attrs %{hours_worked: "456.7", work_description: "some updated work_description", working_day: "2022-11-21"}
  @invalid_attrs %{hours_worked: nil, work_description: nil, working_day: nil}

  defp create_job(_) do
    job = job_fixture()
    %{job: job}
  end

  describe "Index" do
    setup [:create_job]

    test "lists all jobs", %{conn: conn, job: job} do
      {:ok, _index_live, html} = live(conn, ~p"/jobs")

      assert html =~ "Listing Jobs"
      assert html =~ job.work_description
    end

    test "saves new job", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/jobs")

      assert index_live |> element("a", "New Job") |> render_click() =~
               "New Job"

      assert_patch(index_live, ~p"/jobs/new")

      assert index_live
             |> form("#job-form", job: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#job-form", job: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/jobs")

      assert html =~ "Job created successfully"
      assert html =~ "some work_description"
    end

    test "updates job in listing", %{conn: conn, job: job} do
      {:ok, index_live, _html} = live(conn, ~p"/jobs")

      assert index_live |> element("#jobs-#{job.id} a", "Edit") |> render_click() =~
               "Edit Job"

      assert_patch(index_live, ~p"/jobs/#{job}/edit")

      assert index_live
             |> form("#job-form", job: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#job-form", job: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/jobs")

      assert html =~ "Job updated successfully"
      assert html =~ "some updated work_description"
    end

    test "deletes job in listing", %{conn: conn, job: job} do
      {:ok, index_live, _html} = live(conn, ~p"/jobs")

      assert index_live |> element("#jobs-#{job.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#job-#{job.id}")
    end
  end

  describe "Show" do
    setup [:create_job]

    test "displays job", %{conn: conn, job: job} do
      {:ok, _show_live, html} = live(conn, ~p"/jobs/#{job}")

      assert html =~ "Show Job"
      assert html =~ job.work_description
    end

    test "updates job within modal", %{conn: conn, job: job} do
      {:ok, show_live, _html} = live(conn, ~p"/jobs/#{job}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Job"

      assert_patch(show_live, ~p"/jobs/#{job}/show/edit")

      assert show_live
             |> form("#job-form", job: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#job-form", job: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/jobs/#{job}")

      assert html =~ "Job updated successfully"
      assert html =~ "some updated work_description"
    end
  end
end
