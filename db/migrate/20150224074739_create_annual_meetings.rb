class CreateAnnualMeetings < ActiveRecord::Migration
  def change
    create_table :annual_meetings do |t|
      t.datetime :start_at, null: false
      t.integer :fee

      t.timestamps
    end
  end
end
