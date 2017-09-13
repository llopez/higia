class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.integer :doctor_id
      t.integer :patient_id
      t.datetime :date

      t.timestamps
    end
    add_index :appointments, :doctor_id
    add_index :appointments, :patient_id
  end
end
