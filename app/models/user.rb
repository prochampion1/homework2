class User < ApplicationRecord
validates :email, uniqueness: true
validates :name, presence: true
has_many :friendships
has_many :friends, :through => :friendships
has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
has_many :inverse_friends, :through => :inverse_friendships, :source => :user
validates :name, presence: true
validates :email, presence: true, uniqueness: {case_insensitive: false}
validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
has_secure_password


    def incoming_messages
      Message.where(recipient_id: id).order('created_at DESC')
    end

    def last_online
      self.created_at = Time.now
    end

  def is_friend?(user)
    self.friend_ids.include?(user.id)
  end

  def sent_messages
    Message.where(sender_id: id).oreder('created_at DESC')
    end
end
