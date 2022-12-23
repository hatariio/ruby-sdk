module HatariRubySdk
    class HatariException < StandardError
        def initialize(msg="This is a custom exception")
            super(msg)
        end
    end

    class InvalidEventException < HatariException
        def initialize(msg = nil)
            super(msg)
        end
    end

    class InvalidProjectIdException < HatariException
        def initialize(msg = nil)
            super(msg)
        end
    end

    class InvalidApiKeyException < HatariException
        def initialize(msg = nil)
            super(msg)
        end
    end
end