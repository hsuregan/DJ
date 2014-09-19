class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.string :requester
      t.string :email

      t.timestamps
    end
  end
end
