module ApiExceptions
  class ScraperError < ApiExceptions::BaseException
    class HeadingError < ApiExceptions::ScraperError
    end
  end
end