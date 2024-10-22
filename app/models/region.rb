class Region < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :world
  has_many :neighborhood_regions, dependent: :destroy
  has_many :neighborhoods, through: :neighborhood_regions

  delegate :contains?, to: :geometry

  validates_presence_of :name
  validates_presence_of :slug

  serialize :threejs, Hash

  set_rgeo_factory_for_column(:geometry, Mercator::FACTORY.projection_factory)

  def as_json(options={})
    exceptions = [:geometry, :created_at, :updated_at]
    nested_inclusion = {
      neighborhoods: { only: :name }
    }

    final_options = {
      except: exceptions,
      include: nested_inclusion
    }.merge(options)

    super(final_options)
  end

  def generate_bounding_box
    Cartesian::BoundingBox.create_from_geometry(geometry) if geometry
  end

  def simplify_geometry(tolerance=5)
    return nil unless geometry
    rval = Region.connection.execute(<<-SQL).values.first.first
    SELECT ST_AsText(
      ST_Simplify(
        ST_GeomFromText('#{geometry.as_text}', #{geometry.srid}),
        #{tolerance}))
    SQL
    Mercator::FACTORY.projection_factory.parse_wkt(rval)
  end
end
