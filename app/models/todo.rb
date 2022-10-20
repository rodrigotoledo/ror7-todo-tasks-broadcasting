class Todo < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :user
  has_rich_text :content

  validates :title, presence: true
  after_destroy :broadcast_to_application
  after_save :broadcast_to_application

  protected

  def broadcast_to_application
    broadcast_update_to 'todos', target: "todos_#{user_id}", partial: 'todos/list',
                                 locals: { todos: user.todos.all }
  end
end
