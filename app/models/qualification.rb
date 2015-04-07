class Qualification < ActiveRecord::Base
    attr_accessible :alignment_report_images_id, :cylinder_compression_spec,
                    :leakdown, :qdate, :qual_report_images_id,
                    :service_visit_id, :sixgas_report_images_id,
                    :spectrum_report_images_id

    belongs_to :vehicle
    belongs_to :qual_report_images, class_name: :Image
    belongs_to :alignment_report_images, class_name: :Image
    belongs_to :sixgas_report_images, class_name: :Image
    belongs_to :spectrum_report_images, class_name: :Image
    belongs_to :service_visit
    has_many :cylinder_compressions

end
