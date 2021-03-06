defmodule Issues.GithubIssues do

  @user_agent  [ {"User-agent", "Programming Elixir dave@pragprog.com"}]
  @github_url Application.get_env(:issues, :github_url)
  
  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  defp issues_url(user, project), do: "#{@github_url}/repos/#{user}/#{project}/issues"

  def handle_response({:ok, %{status_code: 200, body: body}}), do: {:ok, Poison.Parser.parse!(body)}
  def handle_response({_, %{status_code: _, body: body}}), do: {:error, Poison.Parser.parse!(body)}

end
