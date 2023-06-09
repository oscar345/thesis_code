defmodule ExtendContext do
  @amount_extra_contexts 2

  def file_to_data(filename) do
    filename
    |> File.read!()
    |> Poison.decode!()
  end

  def get_random_context(_, _, extra_contexts, @amount_extra_contexts), do: extra_contexts

  def get_random_context(data, title, extra_contexts, amount) do
    new = Enum.random(data)

    if Map.get(new, "title") != title and Map.get(new, "context") not in extra_contexts do
      get_random_context(data, title, extra_contexts ++ [Map.get(new, "context")], amount + 1)
    else
      get_random_context(data, title, extra_contexts, amount)
    end
  end

  def extends_context(data) do
    old_data = data

    for item <- data do
      extra_contexts = get_random_context(old_data, Map.get(item, "title"), [], 0)

      new_item =
        Map.update!(item, "context", fn context ->
          Enum.reduce([context | extra_contexts], "", fn context, acc -> acc <> context end)
        end)
    end
  end
end

all = ExtendContext.file_to_data("../data/final/test-v2.0.json")

new =
  all
  |> Map.get("data")
  |> ExtendContext.extends_context()

new_all = Map.put(all, "data", new)
File.write("../data/final/test-v2.0-extended.json", Poison.encode!(new_all))
