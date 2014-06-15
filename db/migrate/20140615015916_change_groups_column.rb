class ChangeGroupsColumn < ActiveRecord::Migration
  def self.up
    rename_column :groups, :group, :group_letter
  end

  def self.down
    rename_column :groups, :group_letter, :group
  end
end
