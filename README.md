# mix_file_editor

I wish mix.exs was data

## Usage

```elixir
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
```
