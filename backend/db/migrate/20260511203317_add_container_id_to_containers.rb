class AddContainerIdToContainers < ActiveRecord::Migration[8.1]
  def change
    add_column :containers, :container_id, :string
  end
end
