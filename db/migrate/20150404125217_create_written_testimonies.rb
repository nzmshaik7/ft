class CreateWrittenTestimonies < ActiveRecord::Migration
  def change
    create_table :written_testimonies do |t|
      t.text :user_text

      t.timestamps
    end
  end
end
