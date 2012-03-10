module Boundio
  class Application < Thor
    desc "call", "Call the specified number with the specified cast"
    method_options :tel_to => :string, :cast => :string
    def call
      call = Call.new(options)
      call.save
      puts call.id
    end

    desc "status", "Look up the status of the specified call"
    method_options :tel_id => :string, :start => :string, :end => :string
    def status
      puts client.status(options)
    end

    desc "file", "Create a file for use with boundio"
    method_options :convtext => "string", :filename => "string"
    def file
      puts client.file(options)
    end

    private

    def client 
      @client ||= Boundio::Client.new(ENV["BOUNDIO_USER_SERIAL_ID"], ENV["BOUNDIO_API_KEY"])
    end
  end
end
