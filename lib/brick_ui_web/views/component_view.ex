defmodule BrickUiWeb.ComponentView do
  use BrickUiWeb, :view

  defp _css(styles) do
    Enum.map_join(styles, "; ", fn {property, value} ->
      property = Recase.to_kebab("#{property}")
      "#{property}: #{value}"
    end)
  end

  defp status_tag(%{} = status) do
    content_tag :div, class: "Status Status--tag" do
      style = %{
        backgroundColor: status.color,
        borderColor: status.color
      }

      content_tag(:label, status.label,
        class: "Status-label",
        style: _css(style)
      )
    end
  end

  defp components_to_data(components) do
    Enum.map(components, fn component ->
      %{
        label: component |> Module.split() |> List.last(),
        status: %{
          label: "WIP",
          color: "red"
        }
      }
    end)
  end
end
