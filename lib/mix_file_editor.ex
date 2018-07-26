defmodule MixFileEditor do
  alias MixFileEditor.Parser

  @moduledoc """

  Helper library for reading and writing mix.exs files.

  """

  @doc """
  Read the deps section of the mix file.

  Returns a list of dependency tuples.

  ## Examples

      iex> MixFileEditor.deps("path/to/mix.exs")
      [
        {:phoenix, "~> 1.3.0"},
        {:phoenix_pubsub, "~> 1.0"},
        {:postgrex, ">= 0.0.0"},
        {:gettext, "~> 0.11"},
        {:cowboy, "~> 1.0"}
      ]

  """
  def deps(path) do
    path
    |> File.read!()
    |> Code.string_to_quoted()
    |> Parser.parse_deps()
  end
end
