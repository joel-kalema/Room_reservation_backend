class roomSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :reserved, :description, :price, :pictures

  has_one :user

  def pictures
    rails_blob_path(object.pictures, only_path: true) if object.pictures.attached?
  end
end
