class RemoveLikeCountFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :like_count, :integer
  end
end