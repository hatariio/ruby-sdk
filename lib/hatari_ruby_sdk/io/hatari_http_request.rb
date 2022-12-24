require 'net/http'
require 'uri'
require 'json'
require 'hatari_ruby_sdk/constants'
require 'celluloid/current'
require 'mono_logger'

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
        logger = MonoLogger.new(STDOUT)
        logger.level = MonoLogger::WARN

        def run(client, event = {}, callback = nil)
            begin
                response =  sendEvent()
                handleResult(response)
            rescue => e 
                logger.error("There was an error while sending events to the Keen API." )
               return callback.onError(e.backtrace)
            end
        end

        private

        def sendEvent()
            uri = URI.parse("#{HatariRubySdk::SERVER_ADDRESS}/#{HatariRubySdk::API_VERSION}/events/#{client.projectId}")
            http = Net::HTTP.new(uri.host, uri.port)
            header = {'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Authorization' => client.apiKey}
            req = Net::HTTP::Post.new(url.path, header)
            req.body = @event.to_json
            return http.request(req)
        end

        def handleResult(response)
            return if callback.nil?
            return callback.onSuccess() if response.code == 201
            logger.error("response code is : #{response.code}")
            logger.error("response body : #{response.body}")
            return callback.onError()
        end
    end

end