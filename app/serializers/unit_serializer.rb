class UnitSerializer < ActiveModel::Serializer

  has_one :development

  has_many :views
  has_many :plans

  attributes :id,
    :status,
    :unit_type,
    :development_id,
    :number,
    :price,
    :price_per_m2,
    :bedrooms,
    :bathrooms,
    :parking,
    :internal_in_meters,
    :master_bedroom_in_meters,
    :external_in_meters,
    :aspect,
    :study_nook,
    :storage_cage,
    :no_stacker,
    :max_body_corporate_fee,
    :development_logo_url,
    :stamp_duty,
    :deposit_percent,
    :deposit_due_in_days,
    :stamp_duty_savings,
    :annual_council_rate,
    :deposit,
    :contract_url,
    :created_at,
    :updated_at,
    :views_count,
    :plans_count

  def views_count
    object.views.count
  end

  def plans_count
    object.plans.count
  end

  def development_logo_url
    object.development.logo.try(:url)
  end

end

