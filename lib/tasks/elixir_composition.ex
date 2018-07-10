defmodule PRT.ElixirComposition do
  @moduledoc false

  @spec list_composition(PRT.list_values(), PRT.list_keys()) :: [PRT.wrap_list()]

  def list_composition(list_values, list_keys) do
    list_composition(list_values, list_keys, [])
  end

  @spec list_composition(PRT.list_values() | [], PRT.list_keys(), [PRT.wrap_list()] | []) :: [PRT.wrap_list()]

  defp list_composition([], _, acc), do: acc
  defp list_composition([value | list_values], [h, h2 | _] = list_keys, acc) do
    [first_key, second_key] = Enum.map([h, h2], fn(x) -> String.to_existing_atom(x) end)
    new_list = for n <- list_keys, do: Keyword.new([{first_key, value},{second_key, n}])
    list_composition(list_values, list_keys, new_list ++ acc)
  end
end
