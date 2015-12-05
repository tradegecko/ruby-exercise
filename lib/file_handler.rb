class FileHandler
  
  def self.download_file_from_url url_string
    response = HTTP.get(url_string)
    file_path = File.join Rails.root, 'public', url_string.slice(url_string.rindex('/')+1..-1)
    open(file_path, "wb") do |file|
      file = file.write(response.body)
    end
    return file_path
  end
  
end
