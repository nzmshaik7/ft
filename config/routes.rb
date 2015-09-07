Ft::Application.routes.draw do

  resources :technician_hours
  get "technician_hours/th_for_sli/:id" => 'technician_hours#th_for_sli'

  resources :manufacturer_warranty_types

  resources :payment_types

  get "top/db"
  get "top/analytics"
  get "top/creds"
  get "top/gf"

  resources :insurance_companies

  resources :countries

  resources :states

  resources :counties

  resources :regions

  resources :inventories

  get 'employees/gfnew'
  get 'employees/gfindex'
  get 'employees/:id/gfedit' => 'employees#gfedit'
  resources :employees

  resources :salespeople

  get 'technicians/gfnew'
  get 'technicians/gfindex'
  get 'technicians/:id/gfedit' => 'technicians#gfedit'
  resources :technicians

  resources :stores

  resources :line_item_purposes

  resources :invoice_line_items

  resources :invoices

  resources :payment_methods

  resources :payments

  get 'engine_displacements/gfnew'
  resources :engine_displacements

  get 'submodels/gfnew'
  get 'submodels/gfindex'
  get 'submodels/:id/gfedit' => 'submodels#gfedit'
  resources :submodels

  get 'models/gfnew'
  get 'models/gfindex'
  get 'models/:id/gfedit' => 'models#gfedit'
  resources :models

  resources :makes

  get 'part_names/gfnew'
  get 'part_names/gfindex'
  get 'part_names/:id/gfedit' => 'part_names#gfedit'
  resources :part_names

  get 'part_manufacturers/gfnew'
  get 'part_manufacturers/gfindex'
  get 'part_manufacturers/:id/gfedit' => 'part_manufacturers#gfedit'
  resources :part_manufacturers

  get 'parts/gfnew'
  get 'parts/gfindex'
  get 'parts/:id/gfedit' => 'parts#gfedit'
  resources :parts

  resources :service_parts
  get "service_parts/sp_for_sli/:id" => 'service_parts#sp_for_sli'

  resources :service_categories

  resources :service_descriptions

  resources :service_line_items
  get "service_line_items/sli_for_visit/:id" => 
                                             'service_line_items#sli_for_visit'

  resources :service_journals_events

  resources :service_journals

  get 'service_visits/gfnew0'
  # :id here is a vehicle id
  get 'service_visits/gfnew1/:id' => 'service_visits#gfnew1'
  post 'service_visits/gfnew2' => 'service_visits#gfnew2'
  get 'service_visits/gfindex'
  get "service_visits/gfshow/:id" => 'service_visits#gfshow'
  get "service_visits/gfedit2/:id" => 'service_visits#gfedit2'
  post "service_visits/gfupdate2/:id" => 'service_visits#gfupdate2'
  resources :service_visits

  resources :scheduled_appointments

  resources :scheduled_service_items

  resources :scheduled_services

  resources :service_schedules

  resources :wheel_drives

  resources :colors

  resources :non_ma_maintenances

  resources :gas_mileages

  resources :cylinder_compressions

  resources :qualifications

  resources :code_histories

  resources :tire_td_readings

  resources :bg_systems

  resources :bg_system_covereds

  resources :manufacturer_warranties

  resources :breakdowns

  resources :ts_band_recalls

  resources :automatic_data_link_infos

  get "vehicles/search_int1"
  post "vehicles/match"
  get 'vehicles/gfnew'
  get 'vehicles/gfindex'
  get 'vehicles/:id/gfedit' => 'vehicles#gfedit'
  get 'vehicles/gfsearch1'
  get 'vehicles/svsearch1'
  post 'vehicles/gfmatch1'
  post 'vehicles/gfnew2'
  get 'vehicles/svlist'
  resources :vehicles

  resources :images

  get "written_testimonies/showana/:id" => 'written_testimonies#showana'
  resources :written_testimonies

  resources :upgrade_types

  resources :upgrades

  get 'contracts/gfnew'
  get 'contracts/gfindex'
  get 'contracts/:id/gfedit' => 'contracts#gfedit'
  resources :contracts

  resources :referred_bies

  resources :finance_agreements

  get 'customers/gfnew'
  get 'customers/gfindex'
  get 'customers/:id/gfedit' => 'customers#gfedit'
  get 'customers/gfsearch1'
  get 'customers/svsearch1'
  post 'customers/gfmatch1'
  resources :customers

  devise_for :users, :controllers => {
      :registrations => "ft_devise/registrations",
      :sessions => "ft_devise/sessions",
  }

  devise_scope :user  do
      match '/logout'  => 'devise/sessions#destroy'
  end

  get "mockup/internal_veh"
  get "mockup/multi_veh"
  get "mockup/customer_veh"
  get "mockup/store"
  get "mockup/softwareprinc"
  get "mockup/contract"
  get "mockup/classifications"
  get "mockup/insurance"
  get "mockup/videoTestm"
  get "mockup/writtenTestm"
  get "mockup/contract"
  get "mockup/sixgas"
  get "mockup/alighmentReport"
  get "mockup/classifications"
  get "mockup/insurance"
  get "mockup/loanAgrmnt"
  get "mockup/nonMaMaint"
  get "mockup/paymentAgrmnt"
  get "mockup/qualReport"
  get "mockup/spectrum"
  get "mockup/videoTestm"
  get "mockup/vinDecode"
  get "mockup/vwmaint1"
  get "mockup/vwmaint2"
  get "mockup/vwmaint3"
  get "mockup/writtenTestm"
  get "mockup/bgPaper"

  get "analytics/int1/:id" => 'analytics#int1'
  get "analytics/non_ma_maint/:id" => 'analytics#non_ma_maint'

  get "static/home"
  get "static/signed_up"

  resources :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'static#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
