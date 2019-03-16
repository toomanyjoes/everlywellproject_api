module ApiExceptions
  class TinylinkError < ApiExceptions::BaseException
    class ServerError < ApiExceptions::TinylinkError
    end
  end
end