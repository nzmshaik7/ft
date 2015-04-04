class Qualification < ActiveRecord::Base
    attr_accessible :alignment_report_images_id, :cylinder_compression_spec, :leakdown, :qdate, :qual_report_images_id, :service_visit_id, :sixgas_report_images_id, :spectrum_report_images_id
end
