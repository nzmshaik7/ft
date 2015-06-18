class AddCylinderCompressionToleranceToQualification < ActiveRecord::Migration
  def change
    add_column :qualifications, :cylinder_compression_tolerance, :integer
  end
end
