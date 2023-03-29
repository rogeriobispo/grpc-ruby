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
