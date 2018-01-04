module BibcardInstrumentation
  class LogSubscriber < ActiveSupport::LogSubscriber
    def bibcard(event)
      return unless logger.info?
      name = '%s (%.1fms)' % ["BibCard Person Data", event.duration]
      info "#{color(name, CYAN, true)} #{event.payload[:uri]}"
    end
  end
end
BibcardInstrumentation::LogSubscriber.attach_to :person_data