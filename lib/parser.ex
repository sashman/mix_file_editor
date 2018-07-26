defmodule MixFileEditor.Parser do
  def parse_deps(mix_file_ast) do
    with {:ok, {:defmodule, _, module}} <- mix_file_ast,
         [_, [do: {_, _, module_contents}]] <- module,
         deps_ast <- find_deps(module_contents),
         deps <- parse_deps_ast(deps_ast) do
      deps
    else
      _ -> :error
    end
  end

  defp find_deps(contents) when is_list(contents) do
    contents
    |> Enum.find(&deps_function/1)
  end

  defp deps_function({:defp, _, [{:deps, _, nil} | _]}), do: true
  defp deps_function(_), do: false

  defp parse_deps_ast(deps_ast) do
    with {_, _, defp_contents} <- deps_ast,
         do_block <- defp_contents |> Enum.at(1),
         [do: do_contents] <- do_block do
      do_contents
    end
  end
end
