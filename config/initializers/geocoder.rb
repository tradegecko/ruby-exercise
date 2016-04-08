Geocoder.configure(
  :lookup => :mapquest,
  :api_key => ENV["MAPQUEST_KEY"],
  :timeout => 20,
  :mapquest => {
    :key => ENV["MAPQUEST_KEY"],
  },
)
