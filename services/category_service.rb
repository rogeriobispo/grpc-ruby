class CategoryService < Pb::CategoryService::Service
  def create_category(req, others)
    category = ::Pb::Category.new($category_db.create(req.name, req.description))  
    ::Pb::CategoryResponse.new(category: category)
  end

  def list_category(_req, _others)
    categories = $category_db.all().values.map do |category| 
      ::Pb::Category.new(
        id: category[:id],
        name: category[:name],
        description: category[:description]
      )
    end
    binding.pry 
    ::Pb::CategoryList.new(categories)
  end
end