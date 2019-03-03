defmodule BrickUiWeb.PreviewController do
  use BrickUiWeb, :controller

  def show(conn, %{"name" => name, "variant" => variant}, %{brick_ui: %{namespace: namespace}}) do
    module = Module.safe_concat(namespace, name)

    config = Brick.Component.get_config(module, :default)

    conn
    |> put_layout(false)
    |> put_view(module)
    |> render(module.variant(variant), config[:context] || [])
  end
end
