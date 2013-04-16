class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :service_request_id
      t.string :status
      t.string :service_name
      t.string :service_code
      t.string :description
      t.string :requested_datetime
      t.string :updated_datetime

      t.timestamps
    end
  end
end
