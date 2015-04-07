class CylinderCompression < ActiveRecord::Base
    attr_accessible :cyl_num, :psi, :qualification_id
    belongs_to :qualification
end
