class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  # def accept_friend!
  #   self.acceptance = true
  # end
end
