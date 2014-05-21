ActiveAdmin.register Job do

  permit_params :title, :location, :haveapplied, :interested, :referred

  index do
    selectable_column
    id_column
    column :title do |s|
      a href: admin_job_path(s) do
        s.title
      end
    end
    column :location
    column :link do |s|
      a href: s.link do
        s.link
      end
    end
    column :haveapplied
    column :interested
    column :referred
    column :created_at
    column :updated_at
    actions
  end


end
