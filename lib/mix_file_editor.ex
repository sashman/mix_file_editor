defmodule MixFileEditor do
  alias MixFileEditor.Parser

  @moduledoc """

  Helper library for reading and writing mix.exs files.

  """

  @doc """
  Read the deps section of the mix file. Accepts a glob pattern.

  Returns a map of dependency info.

  ## Examples

      iex> MixFileEditor.get_deps("path/to/mix.exs")
      %{
        path: "path/to/mix.exs"
        deps: %{
          cowboy: %{value: {:cowboy, "~> 1.0"}, version: "~> 1.0"},
          csv: %{value: {:csv, "~> 2.0.0"}, version: "~> 2.0.0"},
          distillery: %{
            value: {{:distillery, "~> 1.5", [runtime: false]}, []},
            version: "~> 1.5"
          },
          ...
        }
      }

      iex> MixFileEditor.get_deps("path/**/mix.exs")
      [
        %{
          path: "path/to/mix.exs"
          deps: %{
            cowboy: %{value: {:cowboy, "~> 1.0"}, version: "~> 1.0"},
            csv: %{value: {:csv, "~> 2.0.0"}, version: "~> 2.0.0"},
            distillery: %{
              value: {{:distillery, "~> 1.5", [runtime: false]}, []},
              version: "~> 1.5"
            },
            ...
          }
        }
      ...]

  """
  def get_deps(path) do
    path
    |> Path.wildcard()
    |> get_deps_for_path_list
  end

  defp get_deps_for_path_list(path_list) when length(path_list) == 1 do
    exact_path = path_list |> List.first()

    %{
      path: exact_path,
      deps:
        exact_path
        |> File.read!()
        |> Code.string_to_quoted()
        |> Parser.parse_deps()
    }
  end

  defp get_deps_for_path_list(path_list) do
    path_list
    |> Enum.map(fn exact_path ->
      %{
        path: exact_path,
        deps:
          exact_path
          |> File.read!()
          |> Code.string_to_quoted()
          |> Parser.parse_deps()
      }
    end)
  end
end
