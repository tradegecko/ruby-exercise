class Quote
  attr_accessor :text, :author, :category

  def initialize options = {}
    self.text     = options[:text]     || options["text"] || options[:quote] || options["quote"]
    self.author   = options[:author]   || options["author"]
    self.category = options[:category] || options["category"]
  end
end
