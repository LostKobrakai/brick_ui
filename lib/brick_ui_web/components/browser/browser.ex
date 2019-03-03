defmodule BrickUiWeb.Components.Browser do
  use Brick.Component, type: :html

  def config(:default) do
    %{
      status: "WIP",
      layout: {BrickUiWeb.Components.Layout, :default},
      context: %{
        panels: [
          "HTML",
          "View",
          "Context",
          "Assets",
          "Info",
          "Notes"
        ]
      }
    }
  end
end
