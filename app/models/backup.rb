class Backup < ActiveRecord::Base
    attr_accessible :info, :table_name, :user_id
end
