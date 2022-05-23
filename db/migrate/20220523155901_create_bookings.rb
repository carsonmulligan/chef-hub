class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.references :user
      t.references :chef
      t.references :review

      t.timestamps
    end
  end
end
