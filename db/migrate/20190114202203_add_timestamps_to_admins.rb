class AddTimestampsToAdmins < ActiveRecord::Migration[5.2]
  def change
    change_table :admins do |t|
      t.timestamps
    end
  end
end
