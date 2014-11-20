module Ejaydj
  class Track
    attr_accessor :name,
                  :album,
                  :artist,
                  :duration_ms,
                  :playlist

    def initialize(attributes={})
      @id            = attributes[:id]
      @name          = attributes[:name]
      @album         = attributes[:album]
      @artist        = attributes[:artist]
      @playlist      = attributes[:playlist]
      @duration_ms   = attributes[:duration_ms]
    end
  end
end
