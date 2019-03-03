defmodule BrickUiWeb.Components.Status do
  use Brick.Component, type: :html
  use Phoenix.HTML

  def render("unlabeled.html", %{status: status}) do
    class = "Status Status--unlabeled"

    class =
      if modifier = status[:modifier] do
        "#{class} Status--#{modifier}"
      else
        class
      end

    content_tag(:div, dot(status), class: class)
  end

  defp dot(status) do
    style = %{
      borderColor: status.color
    }

    content_tag(:span, "",
      class: "Status-dot",
      style: _css(style),
      title: status.label
    )
  end

  defp _css(styles) do
    Enum.map_join(styles, "; ", fn {property, value} ->
      property = Recase.to_kebab("#{property}")
      "#{property}: #{value}"
    end)
  end
end
