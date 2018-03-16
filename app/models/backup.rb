class Backup < ActiveRecord::Base
    #attr_accessible :info, :table_name, :user_id

    def backup_params
	params.require(:backup).permit(:info, :table_name, :user_id)
    end
end
