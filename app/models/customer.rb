class Customer < ActiveRecord::Base
    #attr_accessible :can_text_home_phone, :can_text_mobile_phone, 
     #               :can_text_other_phone, :can_text_work_phone, :cid, 
     #               :city, :date_of_birth, :driver_lic_image_id, 
     #               :driver_lic_num, :driver_lic_state_id, :gender, 
     #               :home_phone, :is_aaa_member, :is_web_registered, 
     #               :joined_date, :mobile_phone, :other_phone,
     #               :referral_credits_earned, :referral_credits_used,
     #               :referredBy_customer_id, :referredBy_id,
     #               :referredBy_other_text, :signup_store_id,
     #               :spouse_id, :spouse_name, :ssn, :state_id,
     #               :street_addr1, :street_addr2, :user_id,
     #               :video_testimony_url, :work_phone,
     #               :written_testimony_id, :zip,
     #               :first_name, :middle_name, :last_name, :email, 
     #               :contact_method
    def customer_params
      params.require(:customer).permit(:can_text_home_phone, :can_text_mobile_phone, 
                    :can_text_other_phone, :can_text_work_phone, :cid, 
                    :city, :date_of_birth, :driver_lic_image_id, 
                    :driver_lic_num, :driver_lic_state_id, :gender, 
                    :home_phone, :is_aaa_member, :is_web_registered, 
                    :joined_date, :mobile_phone, :other_phone,
                    :referral_credits_earned, :referral_credits_used,
                    :referredBy_customer_id, :referredBy_id,
                    :referredBy_other_text, :signup_store_id,
                    #:spouse_id, :spouse_name, 
		    :ssn, :state_id,
                    :street_addr1, :street_addr2, :user_id,
                    :video_testimony_url, :work_phone,
                    :written_testimony_id, :zip,
                    :first_name, :middle_name, :last_name, :email, 
                    :contact_method)
    end

    belongs_to :user
    belongs_to :state
    belongs_to :spouse, class_name: :Customer
    belongs_to :signup_store, class_name: :Store
    belongs_to :referredBy
    belongs_to :referredBy_customer, class_name: :Customer
    belongs_to :driver_lic_state, class_name: :State
    belongs_to :driver_lic_image, class_name: :Image
    belongs_to :written_testimony
    has_many   :vehicles
    has_many   :invoices
    has_many   :payments
    has_many   :payment_methods
    has_many   :finance_agreements

    GENDER_MALE = 61
    GENDER_FEMALE = 62
    GENDER_OTHER = 63

    CONTACT_EMAIL = 91
    CONTACT_TEXT = 92
    CONTACT_CALL = 93

    def genderText
        return 'male'   if gender == GENDER_MALE
        return 'female' if gender == GENDER_FEMALE
        return 'other'  if gender == GENDER_OTHER
        return 'unknown'
    end

    def contactText
        return 'email'  if contact_method == CONTACT_EMAIL
        return 'text'   if contact_method == CONTACT_TEXT
        return 'call'   if contact_method == CONTACT_CALL
        return 'unknown'
    end

    def homeTextFlag
        return 'T' if can_text_home_phone  
        return ''
    end
    def mobileTextFlag
        return 'T' if can_text_mobile_phone  
        return ''
    end
    def workTextFlag
        return 'T' if can_text_work_phone  
        return ''
    end
    def otherTextFlag
        return 'T' if can_text_other_phone  
        return ''
    end

end
