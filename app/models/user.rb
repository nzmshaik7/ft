class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me
    attr_accessible :first_name, :last_name, :role

    # See vpatient if you need to hook user creation: before_create :pre_create

    ROLE_ADMIN = 11
    ROLE_CLERK = 12
    ROLE_MOCKER = 13
    ALL_ROLES = [ ROLE_ADMIN, ROLE_CLERK, ROLE_MOCKER, ]


    def roleText(r = nil)
        r = role  if r.nil?
        return 'empty'           if r.nil?
        return 'Administrator'   if r == ROLE_ADMIN
        return 'Clerk'           if r == ROLE_CLERK
        return 'Mockup Viewer'   if r == ROLE_MOCKER
        return 'Unknown'
    end

end
