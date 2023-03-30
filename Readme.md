## Compilar o proto file.
grpc_tools_ruby_protoc -Iproto --ruby_out=lib --grpc_out=lib proto/<arq>.proto

## run app
bundle exec ruby server/server.rb

