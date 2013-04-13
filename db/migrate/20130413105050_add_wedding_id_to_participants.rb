class AddWeddingIdToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :wedding_id, :integer
  end
end
