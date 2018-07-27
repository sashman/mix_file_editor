defmodule MixFileEditor do
  alias MixFileEditor.Parser

  @moduledoc """

  Helper library for reading and writing mix.exs files.

  """

  @doc """
  Read the deps section of the mix file.

  Returns a map of dependency info.

  ## Examples

      iex> MixFileEditor.deps("path/to/mix.exs")
      %{
        cowboy: %{value: {:cowboy, "~> 1.0"}, version: "~> 1.0"},
        csv: %{value: {:csv, "~> 2.0.0"}, version: "~> 2.0.0"},
        distillery: %{
          value: {{:distillery, "~> 1.5", [runtime: false]}, []},
          version: "~> 1.5"
        },
        ...
      }


  """
  def deps(path) do
    path
    |> File.read!()
    |> Code.string_to_quoted()
    |> Parser.parse_deps()
  end
end
