ActiveAdmin.register Donation do
  permit_params :name, :currency, :amount, :from_name, :from_id
end
