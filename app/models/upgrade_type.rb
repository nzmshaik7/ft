class UpgradeType < ActiveRecord::Base
    #attr_accessible :cost, :name, :added_miles

    def upgrade_type_params
	params.require(:upgrade_type).permit(:cost, :name, :added_miles)
    end
end
