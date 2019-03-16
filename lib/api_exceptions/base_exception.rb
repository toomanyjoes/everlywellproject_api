module ApiExceptions
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :status, :code, :message

    ERROR_DESCRIPTION = Proc.new {|code, message| {status: "error | failure", code: code, message: message}}
    ERROR_CODE_MAP = {
        "TinylinkError::ServerError" =>
            ERROR_DESCRIPTION.call(100, "there was a problem shortening the link"),
        "ScraperError::HeadingError" =>
            ERROR_DESCRIPTION.call(200, "there was a problem writing headings for user"),
        "ExpertSearchError::NoSearchTermsError" =>
            ERROR_DESCRIPTION.call(300, "cannot perform search, no search terms were given")
    }

    def initialize
      error_type = self.class.name.scan(/ApiExceptions::(.*)/).flatten.first
      ApiExceptions::BaseException::ERROR_CODE_MAP
          .fetch(error_type, {}).each do |attr, value|
        instance_variable_set("@#{attr}".to_sym, value)
      end
    end
  end
end