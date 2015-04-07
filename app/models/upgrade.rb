class Upgrade < ActiveRecord::Base
    attr_accessible :contract_id, :cost, :upgrade_type_id
    belongs_to :contract
    belongs_to :upgrade_type
end
