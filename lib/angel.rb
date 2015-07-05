module Angel

  def get_similar startup_name
    @startup = find_startup startup_name
    unless @startup.present?
      puts "Couldn't find the startup from search."
      return false
    end
    puts "Found the startup from search. Getting more info. ID - #{@startup["id"]}"

    fetch_info @startup["id"].to_s
    if @startup["hidden"]
      puts "Startup have it's details hidden. Couldn't proceed."
      return false
    end

    if @startup["markets"].present?
      puts "Got more Info about the Startup. Fetching Market Tags and their children count. ID - #{@startup["id"]}"
      tags_hash = fetch_tag_children @startup["markets"]
    elsif @startup["locations"].present?
      puts "The startup has no Market tags. Fetching from Location tags. ID - #{@startup["id"]}"
      tags_hash = fetch_tag_children @startup["locations"]
    else
      puts "The startup has no Location Tags or Market tags. Couldn't proceed. ID - #{@startup["id"]}"
      return false
    end

    puts "Got Tag Information. Getting startups from the tag. ID - #{@startup["id"]}"
    @similar = {}
    tags_hash.each do |k, v|
      @similar = find_startup_by_tag k
      if @similar.present?
        puts "Found a similar startup!"
        break
      end
    end
    return @similar
  end

  def find_startup startup_name
    params_hash = {
          query: startup_name,
          type: "Startup",
          access_token: ANGEL_TOKEN
        }
    search_url = ANGEL_URL + '/search?' + params_hash.to_param
    results = HTTParty.get(search_url).as_json

    return results.first
  end

  def fetch_info id
    fetch_url = ANGEL_URL + '/startups/' + id + '?access_token=' + ANGEL_TOKEN
    @startup = HTTParty.get(fetch_url).as_json
  end

  def fetch_tag_children tags
    children = {}
    tags.each do |tag|
      unless saved_tag = StartupTag.find_by_angel_id(tag["id"])
        tag_url = ANGEL_URL + '/tags/' + tag["id"].to_s + '?access_token=' + ANGEL_TOKEN
        result = HTTParty.get(tag_url).as_json
        saved_tag = StartupTag.create(:angel_id => tag["id"], :name => tag["name"], :children => result["total"])
      end

      children[saved_tag.angel_id] = saved_tag.children
    end
    Hash[children.sort]
  end

  def find_startup_by_tag tag_id
    @tag = StartupTag.find_by_angel_id tag_id
    params = {
      access_token: ANGEL_TOKEN,
      page: rand(1..@tag.result_pages)
    }
    fetch_url = ANGEL_URL + '/tags/' + @tag.angel_id.to_s + '/startups?' + params.to_param
    results = HTTParty.get(fetch_url).as_json
    unless results.present?
      return false
    end

    @tag.update_attributes(:result_pages => results["last_page"])

    results["startups"].each do |startup|
      if startup["hidden"]
        next
      else
        return {
                :name => startup["name"],
                :summary =>startup["high_concept"]
                }
        break
      end
    end
  end

end
