class DevelopmentSerializer < ActiveModel::Serializer

  has_many :photos
  has_one :logo

  attributes :id, :lat, :lng,
    :address,
    :city, 
    :region_name, 
    :suburb_name, 
    :ready_at,
    :gym,
    :pool,
    :spa,
    :sauna,
    :steam_room,
    :rooftop_deck,
    :has_double_glazed_windows,
    :ceiling_height_at_living_area_in_meters,
    :units_count,
    :units_sold_count,
    :created_at,
    :updated_at

  def region_name
    object.region.name
  end

  def suburb_name
    object.suburb.name
  end

  def units_sold_count
    object.units.sold.count
  end

end

