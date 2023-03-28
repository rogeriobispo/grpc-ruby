class CategoryDB
  attr_accessor :db

  def initialize
    @db = {}
  end

  def create(name, description)
    category = {name: name, description: description }
    id = category.hash.abs
    db[id] = category.merge!(id: id.to_s)
    category
  end

  def all()
    db.values
  end

  def find(id)
    db[id.to_i]
  end
end