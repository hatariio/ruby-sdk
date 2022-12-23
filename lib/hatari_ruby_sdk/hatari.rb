require 'hatari_ruby_sdk/hatari_exceptions/exception'
require 'hatari_ruby_sdk/constants'
require 'hatari_ruby_sdk/io/hatari_http_request'

module HatariRubySdk
    class HatariClient
        attr_reader :projectId, :apiKey, :http_req_pool

        def initialize(projectId = '', apiKey = '')
            raise InvalidProjectIdException.new "Invalid project ID specified: #{projectId}" if projectId.nil? || projectId.length == 0
            raise InvalidApiKeyException.new "Invalid api key specified: #{apiKey}" if apiKey.nil? || apiKey.length == 0
            @projectId = projectId
            @apiKey = apiKey
            @http_req_pool = HatariHttpRequest.pool(size: HatariRubySdk::NUM_THREADS_FOR_HTTP_REQUESTS)
        end

        def push_event(event = {}, callback)
            @http_req_pool.async.run(self, event, callback)
        end
    end
end