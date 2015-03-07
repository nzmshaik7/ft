class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me
    attr_accessible :first_name, :last_name, :role

    # validate :password_complexity
    # password complexity is handled in ft_devise/registrations_controller.rb

    before_create :pre_create

    ROLE_ADMIN = 11
    ROLE_CLERK = 12
    ROLE_MOCKER = 13
    ROLE_CUSTOMER = 14
    ALL_ROLES = [ ROLE_ADMIN, ROLE_CLERK, ROLE_MOCKER, ROLE_CUSTOMER, ]


    def roleText(r = nil)
        r = role  if r.nil?
        return 'empty'           if r.nil?
        return 'Administrator'   if r == ROLE_ADMIN
        return 'Clerk'           if r == ROLE_CLERK
        return 'Mockup Viewer'   if r == ROLE_MOCKER
        return 'Customer'   if r == ROLE_CUSTOMER
        return 'Unknown'
    end

    def pre_create
        if not self.encrypted_password.nil?  # devise called us
            logger.info("==== create from devise")
            self.role = ROLE_CUSTOMER
        end
    end


end
