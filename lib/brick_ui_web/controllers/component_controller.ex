defmodule BrickUiWeb.ComponentController do
  use BrickUiWeb, :controller

  def index(conn, _, %{brick_ui: %{components: components, namespace: namespace}}) do
    component = List.first(components)
    rest = String.replace_prefix("#{component}", "#{namespace}.", "")
    name = redirect(conn, to: "/#{rest}/default")
  end

  def show(conn, %{"name" => name, "variant" => variant}, %{brick_ui: %{namespace: namespace}}) do
    module = Module.safe_concat(namespace, name)

    with {:ok, variant} <- BrickUi.variant_from_string(module, variant) do
      config = Brick.Component.get_config(module, :default)

      entity = %{
        id: "test",
        title: config[:title],
        status: %{
          color: "red",
          label: "WIP"
        }
      }

      render(conn, "show.html", entity: entity, name: name, variant: variant)
    end
  end
end
