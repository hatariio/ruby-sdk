require 'net/http'
require 'hatari_ruby_sdk/constants'
require 'celluloid/current'

module HatariRubySdk
    class UploadEventCallback 
        def onSuccess
            raise 'Implement this method'
        end

        def onError(error_message)
            raise 'Implement this method'
        end
    end

    class HatariHttpRequest
        include Celluloid
        attr_accessor :client, :event, :callback

        def run(client, event = {}, callback = nil)
            begin
                response =  sendEvent()
                handleResult(response)
            rescue => e 
               puts "There was an error while sending events to the Keen API." 
               return callback.onError(e.backtrace)
            end
        end

        private

        def sendEvent()
            url = URI("#{HatariRubySdk::SERVER_ADDRESS}/#{HatariRubySdk::API_VERSION}/events/#{client.projectId}")
            http = Net::HTTP.new(uri.host, uri.port)
            header = {'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Authorization' => client.apiKey}
            req = Net::HTTP::Post.new(url.path, header)
            req.body = @event.to_json
            return http.request(req)
        end

        def handleResult(response)
            return if callback.nil?
            return callback.onSuccess() if response.code == 201
            puts "response code is : #{response.code}"
            puts "response body : #{response.body}"
            return callback.onError()
        end
    end

end