# User to Admin Messaging System

## Overview
A messaging system where users can send messages with a title, body, and screenshot to the admin. Admins can view all messages, mark them as read, and display a success message after each action.

---

## Features
- **User Message Submission:** Users can send messages with a title, body, and optional screenshot.
- **Processing Indicator:** A "Processing..." message appears when a user submits a message.
- **Success Flash Messages:** Users see a success message after submitting a message.
- **Admin Dashboard:** Admins can view and manage messages.
- **Mark as Read:** Admins can mark messages as "Read" with a success confirmation.
- **User Authentication:** Secure access control for users and admins.

---

## Setup Instructions

### 1. Install Rails & Dependencies
Ensure you have Ruby on Rails installed. If not, install it:
```sh
# Install Rails (if not installed)
gem install rails

# Create a new Rails app
rails new user_admin_messaging -d postgresql
cd user_admin_messaging
```

### 2. Install Devise for Authentication
```sh
bundle add devise
rails generate devise:install
rails generate devise User
rails db:migrate
```

### 3. Set Up User Roles
Modify the `User` model (`app/models/user.rb`) to include roles:
```ruby
class User < ApplicationRecord
  enum role: { user: 0, admin: 1 }
end
```

Generate and run a migration to add the role column:
```sh
rails generate migration AddRoleToUsers role:integer, default:0
rails db:migrate
```

### 4. Generate Message Model
```sh
rails generate model Message title:string body:text status:string user:references image:attachment
rails db:migrate
```

### 5. Implement Controllers and Views
#### Messages Controller (`app/controllers/messages_controller.rb`)
```ruby
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:index, :update_status]

  def index
    @messages = Message.all
  end

  def new
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to root_path, notice: 'Your message has been sent successfully!'
    else
      render :new
    end
  end

  def update_status
    @message = Message.find(params[:id])
    if @message.update(status: 'read')
      redirect_to messages_path, notice: 'Message marked as read.'
    else
      redirect_to messages_path, alert: 'Error updating message status.'
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :body, :image)
  end

  def check_admin
    redirect_to root_path unless current_user.admin?
  end
end
```

### 6. Define Routes (`config/routes.rb`)
```ruby
Rails.application.routes.draw do
  devise_for :users
  root 'messages#new'
  resources :messages, only: [:new, :create, :index] do
    patch 'update_status', on: :member
  end
end
```

### 7. Update Views
#### User Message Form (`app/views/messages/new.html.erb`)
```erb
<%= form_with(model: @message, local: true, html: { id: 'message_form' }) do |form| %>
  <%= form.label :title %>
  <%= form.text_field :title %>

  <%= form.label :body %>
  <%= form.text_area :body %>

  <%= form.label :image %>
  <%= form.file_field :image %>

  <%= form.submit 'Send', id: 'submit_button' %>

  <div id="processing_message" style="display:none;">Processing...</div>
<% end %>
```

#### Admin Dashboard (`app/views/messages/index.html.erb`)
```erb
<h1>Admin Dashboard - Messages</h1>
<% @messages.each do |msg| %>
  <div class="message">
    <p><strong>Title:</strong> <%= msg.title %></p>
    <p><strong>Body:</strong> <%= msg.body %></p>
    <% if msg.image.attached? %>
      <%= image_tag msg.image %>
    <% end %>
    <p><strong>Status:</strong> <%= msg.status %></p>

    <%= link_to "Mark as Read", update_status_message_path(msg), method: :patch, class: "btn btn-primary" %>
  </div>
<% end %>
```

### 8. Add JavaScript for Processing Indicator (`app/assets/javascripts/message_processing.js`)
```javascript
document.addEventListener("DOMContentLoaded", function() {
  const form = document.getElementById("message_form");
  const processingMessage = document.getElementById("processing_message");
  const submitButton = document.getElementById("submit_button");

  form.addEventListener("submit", function() {
    processingMessage.style.display = "block";
    submitButton.disabled = true;
  });
});
```

### 9. Display Flash Messages in Layout (`app/views/layouts/application.html.erb`)
```erb
<% if notice %>
  <div class="flash notice"><%= notice %></div>
<% end %>
<% if alert %>
  <div class="flash alert"><%= alert %></div>
<% end %>
```

### 10. Style Messages (`app/assets/stylesheets/application.css`)
```css
.flash {
  padding: 10px;
  margin: 20px;
  border-radius: 5px;
}
.flash.notice {
  background-color: #28a745;
  color: white;
}
.flash.alert {
  background-color: #dc3545;
  color: white;
}
#processing_message {
  font-size: 18px;
  color: #ff9800;
  font-weight: bold;
}
```

### 11. Start the Rails Server
```sh
rails server
```

Visit `http://localhost:3000` to test the application.

---

## Summary
1. **User submits a message → Processing message appears.**
2. **Message is saved → Success message is shown.**
3. **Admin views messages and marks as read → Success confirmation.**

---

## Future Enhancements
- Add **real-time notifications** using ActionCable.
- Implement **message replies** for user-admin communication.
- Add **pagination** for admin messages.

Enjoy coding! 🚀
