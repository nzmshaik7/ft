class CylinderCompression < ActiveRecord::Base
    #attr_accessible :cyl_num, :psi, :qualification_id
    def cylinder_compression_params
	params.require(:cylinder_compression).permit(:cyl_num, :psi, :qualification_id)
    end
    belongs_to :qualification
end
