class Todo < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :user
  has_rich_text :content

  validates :title, presence: true
  after_create :notify_external_provider
  after_destroy :broadcast_to_application
  after_save :broadcast_to_application

  protected

  def broadcast_to_application
    broadcast_update_to 'todos', target: "todos_#{user_id}", partial: 'todos/list',
                                 locals: { todos: user.todos.all }
  end

  def notify_external_provider
    TodosService.create(user.id, user.external_auth_id)
  end
end
