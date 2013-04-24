class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.datetime :datetime
      t.string :summary
      t.string :type
      t.references :request
      # Don't use timestamps for now; stick to strict spec
      #t.timestamps
    end
  end
end
