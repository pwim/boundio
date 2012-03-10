module Boundio
  class Application < Thor
    desc "call NUMBER CAST", "Call the specified number with the specified cast"
    def call(number, cast)
      puts client.call(number, cast)
    end

    desc "status ID", "Look up the status of the specified call"
    def status(id)
      puts client.status(id)
    end

    private

    def client 
      @client ||= Boundio::Client.new(ENV["BOUNDIO_USER_SERIAL_ID"], ENV["BOUNDIO_API_KEY"])
    end
  end
end
