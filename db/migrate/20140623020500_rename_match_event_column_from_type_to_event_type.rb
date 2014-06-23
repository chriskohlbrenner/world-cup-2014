class RenameMatchEventColumnFromTypeToEventType < ActiveRecord::Migration
  def self.up
    rename_column :match_stats, :type, :event_type
  end

  def self.down
    rename_column :match_stats, :event_type, :type
  end
end
