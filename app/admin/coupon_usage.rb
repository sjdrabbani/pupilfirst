ActiveAdmin.register CouponUsage do
  include DisableIntercom

  menu parent: 'Admissions'

  actions :all, except: [:destroy, :new]

  scope :all
  scope :redeemed
  scope :referrals

  preserve_default_filters!
  filter :redeemed_at_not_null, as: :boolean, label: 'Redeemed'
  filter :rewarded_at_not_null, as: :boolean, label: 'Rewarded'
  filter :referrer, collection: proc { BatchApplicant.with_referrals }

  controller do
    def scoped_collection
      # TODO: More N+1 queries to avoid here
      super.includes(:coupon, :batch_application)
    end
  end

  index do
    column :coupon
    column :batch_application
    column :referrer
    column :redeemed_at do |coupon_usage|
      coupon_usage.redeemed_at || 'Not Redeemed'
    end

    actions
  end

  show do
    attributes_table do
      row :coupon
      row :batch_application
      row :redeemed_at
      row :rewarded_at
      row :notes
    end
  end

  permit_params :rewarded_at, :notes

  form do |f|
    f.semantic_errors(*f.object.errors.keys)

    f.inputs do
      f.input :coupon, input_html: { disabled: true }
      f.input :batch_application, input_html: { disabled: true }
      f.input :redeemed_at, input_html: { disabled: true }, as: :datepicker
      f.input :rewarded_at, as: :string, input_html: { class: 'date-time-picker', data: { format: 'Y-m-d H:i:s O', step: 30 } }, placeholder: 'YYYY-MM-DD HH:MM:SS'
      f.input :notes
    end

    f.actions
  end
end
