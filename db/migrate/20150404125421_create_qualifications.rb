class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.datetime :qdate
      t.integer :leakdown
      t.integer :qual_report_images_id
      t.integer :alignment_report_images_id
      t.integer :sixgas_report_images_id
      t.integer :spectrum_report_images_id
      t.integer :cylinder_compression_spec
      t.integer :service_visit_id

      t.timestamps
    end
  end
end
