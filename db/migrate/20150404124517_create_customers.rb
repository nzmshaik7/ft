class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :cid
      t.integer :user_id
      t.string :street_addr1
      t.string :street_addr2
      t.string :city
      t.integer :state_id
      t.string :zip
      t.string :home_phone
      t.boolean :can_text_home_phone
      t.string :work_phone
      t.boolean :can_text_work_phone
      t.string :mobile_phone
      t.boolean :can_text_mobile_phone
      t.string :other_phone
      t.boolean :can_text_other_phone
      t.datetime :joined_date
      t.boolean :is_aaa_member
      t.boolean :is_web_registered
      t.string :spouse_name
      t.integer :spouse_id
      t.integer :signup_store_id
      t.integer :referredBy_id
      t.integer :referredBy_customer_id
      t.string :referredBy_other_text
      t.string :ssn
      t.string :driver_lic_num
      t.integer :driver_lic_state_id
      t.integer :driver_lic_image_id
      t.datetime :date_of_birth
      t.integer :gender
      t.string :video_testimony_url
      t.integer :written_testimony_id
      t.integer :referral_credits_earned
      t.integer :referral_credits_used

      t.timestamps
    end
  end
end
