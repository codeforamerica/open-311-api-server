class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests, { id: false } do |t|
      t.string :service_request_id
      t.string :status
      t.string :service_name
      t.string :service_code
      t.string :description
      t.string :requested_datetime
      t.string :updated_datetime
      # Don't use timestamps for now; stick to strict 311 spec
      #t.timestamps
    end
  end
end
