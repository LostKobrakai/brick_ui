defmodule BrickUi do
  @moduledoc """
  BrickUi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def variant_from_string(module, variant) do
    case Enum.find(module.variants(), &(Atom.to_string(&1) == variant)) do
      nil -> {:error, :unknown_variant}
      variant when is_atom(variant) -> {:ok, variant}
    end
  end
end
