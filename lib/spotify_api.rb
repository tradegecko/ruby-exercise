class SpotifyApi

  attr_accessor :artist, :track, :player

  def initialize(artist)
    @artist = RSpotify::Artist.search(artist).first
    @track = get_random_track
    @player = get_track_url
  end

  # Returns random track from artist
  def get_random_track
    @artist.top_tracks(:us).sample unless @artist.nil?
  end

  # Returns the track url
  def get_track_url
    RSpotify::Track.find(@track.id).external_urls["spotify"] unless @track.nil?
  end


end
