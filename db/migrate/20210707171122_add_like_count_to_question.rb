class AddLikeCountToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :like_count, :integer
  end
end
