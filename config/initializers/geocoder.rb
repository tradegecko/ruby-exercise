Geocoder.configure(
  :lookup => :mapquest,
  :api_key => ENV["MAPQUEST_KEY"],
  :timeout => 10,
  :ip_lookup=> :telize,
  :mapquest => {
    :key => ENV["MAPQUEST_KEY"],
  },
)
