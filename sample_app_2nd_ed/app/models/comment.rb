class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :micropost

  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'comments.created_at DESC'

  def self.get_comments_by_micropost(micropost)
    where("micropost_id = :micropost_id",
          micropost_id: micropost.id)
  end
end
