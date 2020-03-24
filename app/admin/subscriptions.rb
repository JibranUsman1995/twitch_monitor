ActiveAdmin.register Subscription do
  permit_params :name, :message, :sub_plan, :sub_type
end
