class User < ApplicationRecord
  has_many :messages, foreign_key: :author_id, dependent: :destroy
  validates :email, presence: true

  def self.offline
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers "online"
    where.not(id: ids)
  end

  def self.online
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers "online"
    where(id: ids)
  end
end
