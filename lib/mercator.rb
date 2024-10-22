# reference: http://www.daniel-azuma.com/blog/archives/164
class Mercator
  SRID = 3785

  # TODO: Figure out why this is different to the default simple_mercator_factory
  FACTORY = RGeo::Geographic.projected_factory(
        projection_proj4: '+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs',
        projection_srid: 3785,
        srid: 4326)

  # Create a simple mercator factory. This factory itself is
  # geographic (latitude-longitude) but it also contains a
  # companion projection factory that uses EPSG 3785.
  # SHIT DONT WORK
  # FACTORY = RGeo::Geographic.simple_mercator_factory

  class << self
    def to_geographic(geometry)
      FACTORY.unproject geometry
    end

    def to_projected(geometry)
      FACTORY.project geometry
    end
  end
end
