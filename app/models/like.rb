class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :secret
  validates :user_id, presence: true
  validates :secret_id, presence: true
end
