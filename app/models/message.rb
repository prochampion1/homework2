class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates_presence_of :body, :conversation_id, :user_id
  scope :unread, -> { where(read_at: nil?) }

  
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
 def mark_as_read!
     self.read_at = Time.now 
     
  end

  def read?
    self.read_was.nil? ? false : true
  end
end  