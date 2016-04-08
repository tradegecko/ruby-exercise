Geocoder.configure(
  :lookup => :mapquest,
  :api_key => ENV["MAPQUEST_KEY"],
  :timeout => 10,
  :mapquest => {
    :key => ENV["MAPQUEST_KEY"],
  },
)
