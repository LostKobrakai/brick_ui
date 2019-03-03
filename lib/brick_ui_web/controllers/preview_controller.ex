defmodule BrickUiWeb.PreviewController do
  use BrickUiWeb, :controller

  def show(conn, %{"name" => name, "variant" => variant}, %{brick_ui: %{namespace: namespace}}) do
    module = Module.safe_concat(namespace, name)

    config = Brick.Component.get_config(module, :default)

    conn
    |> put_layout(select_layout(config[:layout]))
    |> put_view(module)
    |> render(module.variant(variant), config[:context] || [])
  end

  defp select_layout(nil), do: false
  defp select_layout({module, variant}), do: {module, module.variant(variant)}
end
