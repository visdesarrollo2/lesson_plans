require 'socket'
require 'server/request'
require 'server/response'

class Server
  def initialize(port:, &handler)
    self.port    = port
    self.handler = handler
    @thread      = nil
  end

  def start
    client   = TCPServer.new(port).accept
    request  = Request.from_http client
    response = Response.new
    handler.call request, response
    client.print response.to_http
    client && client.close
  end

  def stop
  end

  private

  attr_accessor :port, :handler
end
