defmodule BrickUiWeb.LayoutView do
  use BrickUiWeb, :view

  defp build_title(title, project_title) when is_binary(title) do
    "#{title} | #{project_title}"
  end

  defp build_title(_, project_title) do
    project_title
  end
end
