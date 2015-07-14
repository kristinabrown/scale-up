class AddIndexToEventsForDate < ActiveRecord::Migration
  def change
    add_index :events, :date
  end
end
