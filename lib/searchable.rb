module Searchable
  def search(name)
    all.detect {|element| element.name.downcase == name.downcase}
  end
end