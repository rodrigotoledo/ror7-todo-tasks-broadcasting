class Todo < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :user
  has_rich_text :content

  validates :title, presence: true
  after_create_commit :set_todo
  after_update_commit :update_todo
  after_destroy_commit :destroy_todo

  private

  def set_todo
    broadcast_prepend_to "todos", partial: "todos/todo", target: "todos"
  end

  def update_todo
    broadcast_update_to "todos", partial: "todos/todo", target: "todo_#{id}"
  end

  def destroy_todo
    broadcast_remove_to "todo_#{id}"
  end
end
