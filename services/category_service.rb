class CategoryService < Pb::CategoryService::Service
  def create_category(req, others)
    category = ::Pb::Category.new($category_db.create(req.name, req.description))
    ::Pb::CategoryResponse.new(category: category)
  end

  def create_category_stream(req)
    categories = []
    req.each_remote_read do |category|
      categories.push(
        ::Pb::Category.new(
          name: category.name,
          description: category.description
        )
      )
    end
    
    ::Pb::CategoryList.new(categories: categories)
  end
      
  def create_category_bidirectional_stream(categories) 
    CategoryEnumerator.new(categories).each_item
  end

  def list_category(_req, _others)
    categories = $category_db.all().map do |category|
      ::Pb::Category.new(
        id: category[:id],
        name: category[:name],
        description: category[:description]
      )
    end

    ::Pb::CategoryList.new(categories: categories)
  end

  def get_category(req, _others)
    id = req.id

    category = $category_db.find(id)

    ::Pb::Category.new(category) if category
  end
end

class CategoryEnumerator
  def initialize(categories)
    @categories = categories
  end
  def each_item
    return enum_for(:each_item) unless block_given?
    begin
      @categories.each do |category|
        yield ::Pb::Category.new($category_db.create(category.name, category.description)) 
      end
    rescue StandardError => e
      fail e # signal completion via an error
    end
  end
end