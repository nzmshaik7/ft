class Upgrade < ActiveRecord::Base
    attr_accessible :contract_id, :cost, :upgrade_type_id
end
