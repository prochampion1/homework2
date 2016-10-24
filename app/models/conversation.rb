class Conversation < ApplicationRecord
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
  belongs_to :user
  has_many :messagses, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id,recipient_id) do
      where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.recipient_id = ? AND conversations.sender_id = ?)", sender_id,recipient_id, recipient_id, sender_id)
    end
    
    scope :for, -> (user_id) do
      where("conversations.sender_id = ? OR conversations.recipient_id = ?", user_id, user_id)
    end



end