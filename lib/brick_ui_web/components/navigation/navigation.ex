defmodule BrickUiWeb.Components.Navigation do
  use Brick.Component, type: :html

  def config(:default) do
    %{
      status: "WIP",
      context: %{
        components: [
          %{
            label: "Test"
          }
        ]
      }
    }
  end
end
