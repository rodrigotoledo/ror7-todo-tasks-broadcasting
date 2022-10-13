# frozen_string_literal: true

module Api
  class TodosController < ActionController::API
    before_action :set_todo, only: %i[update destroy]
    def index
      user = User.first
      render json: user.todos
    end

    def create
      user = User.first
      @todo = user.todos.build(todo_params)
      if @todo.save
        render json: @todo, status: :created
      else
        render json: { data: { message: 'Error on create' } }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /todos/1 or /todos/1.json
    def update
      if @todo.update(todo_params)
        render json: { nothing: true }, status: :ok
      else
        render json: { data: { message: 'Error on save' } }, status: :unprocessable_entity
      end
    end

    # DELETE /todos/1 or /todos/1.json
    def destroy
      @todo.destroy
      head :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:title, :content, :done)
    end
  end
end
