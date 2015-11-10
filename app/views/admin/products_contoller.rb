<%= form_for [:admin, @product] do |f| %>

  <div class="group">
    <%= f.label("標題") %>
    <%= f.text_field :title %>
  </div>

  <div class="group">
    <%= f.label("敘述") %>
    <%= f.text_area :description %>
  </div>

  <div class="group">
    <%= f.label("數量") %>
    <%= f.text_field :quantity %>
  </div>

  <div class="group">
    <%= f.label("價錢") %>
    <%= f.text_field :price %>
  </div>

  <%= f.submit "Submit", data: { disable_with: "Submitting..." } %>

<% end %>