# mix_file_editor

I wish mix.exs was data

## Usage

Read deps of a mix file, can also specify a glob pattern to read multiple `mix.exs` at once.

```elixir
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
```
