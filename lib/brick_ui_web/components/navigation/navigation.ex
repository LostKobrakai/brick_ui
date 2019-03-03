defmodule BrickUiWeb.Components.Navigation do
  use Brick.Component, type: :html
  use Phoenix.HTML

  def config(:default) do
    %{
      status: "WIP",
      layout: {BrickUiWeb.Components.Layout, :default},
      context: %{
        navigation: [
          %{
            items: [
              %{
                label: "Atoms",
                id: "atoms",
                items: [
                  %{
                    label: "Component 1"
                  },
                  %{
                    label: "Component 2",
                    status: %{
                      color: "green",
                      label: "Success"
                    }
                  }
                ]
              },
              %{
                label: "Molecules",
                id: "molecules",
                items: [
                  %{
                    label: "Component 1"
                  },
                  %{
                    label: "Component 2",
                    status: %{
                      color: "green",
                      label: "Success"
                    }
                  }
                ]
              }
            ],
            label: "Components",
            name: "components"
          }
        ]
      }
    }
  end

  defp leaves(items, root, current, level) do
    Enum.map(items, fn
      %{items: items} = item ->
        list = leaves(items, root, current, level + 1)

        content = [
          ~E"""
          <h4 class="Tree-collectionLabel" data-role="toggle">
            <span><%= item.label %></span>
          </h4>
          """,
          content_tag(:ul, list, class: "Tree-collectionItems", data: [role: "items"])
        ]

        content_tag(:li, content,
          class: "Tree-item Tree-collection Tree-depth-#{level}",
          data: [behaviour: "collection", id: "tree--#{root.name}-collection-#{item[:id]}"]
        )

      item ->
        is_current = false

        ~E"""
        <li class="Tree-item Tree-entity<%= if is_current do %> is-current<% end %>"<%= if is_current do %> data-state="current"<% end %> data-role="item">
          <a class="Tree-entityLink" href="<%= item[:url] %>" data-pjax>
            <span><%= item.label %></span>
            <%= if item[:status] do %>
              <%= render BrickUiWeb.Components.Status, "unlabeled.html", item %>
          <% end %>
          </a>
        </li>
        """
    end)
  end
end
