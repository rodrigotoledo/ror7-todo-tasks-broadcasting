require 'google/cloud/firestore'
class TodosService
  def self.connection
    Google::Cloud::Firestore.new project_id: 'ror-real-time',
                                 keyfile: Rails.application.credentials.keyfile
  end

  def self.all
    all = []
    todos_database = connection.col('todos').order(:created_at, :desc)
    todos_database.get do |todo_database|
      all << todo_database.data
    end
    all
  end

  def self.create(user_id, external_auth_id)
    query = connection.collection('external_provider_notifications').where(:user_id, '=', user_id).where(:finished, '=',
                                                                                                         false).get
    return unless query.first.nil?

    connection.collection('external_provider_notifications').add({
                                                                   user_id: user_id,
                                                                   external_auth_id: external_auth_id,
                                                                   finished: false
                                                                 })
  end
end
