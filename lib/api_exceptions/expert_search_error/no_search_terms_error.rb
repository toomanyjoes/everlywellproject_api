module ApiExceptions
  class ExpertSearchError < ApiExceptions::BaseException
    class NoSearchTermsError < ApiExceptions::ExpertSearchError
    end
  end
end