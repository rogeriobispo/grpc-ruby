# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: category.proto for package 'pb'

require 'grpc'
require_relative 'category_pb'

module Pb
  module CategoryService
    class Service

      include ::GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'pb.CategoryService'

      rpc :CreateCategory, ::Pb::CreateCategoryRequest, ::Pb::CategoryResponse
      rpc :CreateCategoryStream, stream(::Pb::CreateCategoryRequest), ::Pb::CategoryList
      rpc :ListCategory, ::Pb::Blank, ::Pb::CategoryList
      rpc :GetCategory, ::Pb::CategoryGetRequest, ::Pb::Category
    end

    Stub = Service.rpc_stub_class
  end
end
