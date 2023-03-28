#!/usr/bin/env ruby
require 'rubygems'
require_relative '../lib/category_services_pb'
require_relative '../services/category_service'
require_relative '../db/category_db'
require 'pry'

$category_db = CategoryDB.new

class CategoryServer
  class << self
    def start
      start_grpc_server
    end
    private
    def start_grpc_server
      @server = GRPC::RpcServer.new
      @server.add_http2_port("0.0.0.0:50052", :this_port_is_insecure)
      @server.handle(CategoryService)
      @server.run_till_terminated
    end
  end
end

CategoryServer.start