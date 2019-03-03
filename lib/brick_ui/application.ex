defmodule BrickUi.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children =
      if Application.get_env(:brick_ui, :start_own_styleguide, false) do
        [BrickUiWeb.Endpoint]
      else
        []
      end

    opts = [strategy: :one_for_one, name: BrickUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    BrickUiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
