class AddViewCountToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :view_count, :integer
    #add_column -> method available through ActiveRecord
    #:questions -> the table we're adding to
    #:view_count -> the column we're adding
    #:integer -> the type of the column
  end
end