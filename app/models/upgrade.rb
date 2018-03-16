class Upgrade < ActiveRecord::Base
    #attr_accessible :contract_id, :cost, :upgrade_type_id
    def upgrade_params
	params.require(:upgrade).permit(:contract_id, :cost, :upgrade_type_id)
    end
    belongs_to :contract
    belongs_to :upgrade_type
end
