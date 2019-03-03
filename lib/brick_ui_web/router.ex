defmodule BrickUiWeb.Router do
  use BrickUiWeb, :router

  pipeline :browser do
    plug(:put_config)
    plug(:put_routes)
  end

  scope "/", BrickUiWeb do
    pipe_through(:browser)

    get("/", ComponentController, :index)
    get("/:name/:variant", ComponentController, :show)
    get("/:name/:variant/preview", PreviewController, :show)
  end

  def put_config(conn, _) do
    assign(conn, :config, %BrickUi.Config{})
  end

  def put_routes(conn, _) do
    routes = fn _name, _action, _params ->
      "#"
    end

    assign(conn, :routes, routes)
  end

  # Override plug
  def init(opts) do
    phx_opts = super(opts)

    components =
      case Keyword.fetch(opts, :components) do
        {:ok, components} ->
          {:ok, components}

        :error ->
          application = Keyword.fetch!(opts, :application)
          {:retrieve, application}
      end

    brick_ui_opts = %{
      components: components,
      namespace: Keyword.fetch!(opts, :namespace)
    }

    %{phx_opts: phx_opts, brick_ui_opts: brick_ui_opts}
  end

  def call(conn, %{phx_opts: phx_opts, brick_ui_opts: brick_ui_opts}) do
    brick_ui_opts =
      Map.update!(brick_ui_opts, :components, fn
        {:ok, components} -> components
        {:retrieve, application} -> Brick.components(application)
      end)

    conn
    |> assign(:brick_ui, brick_ui_opts)
    |> super(phx_opts)
  end
end
