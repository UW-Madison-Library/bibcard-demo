# Used to interact with Linked Data for author information.
class LinkedData

  def self.lcnaf_person(id)
    begin
      lcnaf_uri = RDF::URI.new("http://id.loc.gov/authorities/names/#{id}")
      raw_data = fetch_person_data(lcnaf_uri)
      if raw_data
        Spira.repository = RDF::Repository.new.from_ntriples(raw_data)
        viaf_uri = Spira.repository.query(predicate: BibCard::SCHEMA_SAME_AS, object: lcnaf_uri).first.subject
        viaf_uri.as(BibCard::Person)
      end
    rescue BibCard::EntityNotFoundException, BibCard::InvalidURIException
      nil
    end
  end


  private

  def self.fetch_person_data(lcnaf_uri)
    if ActionController::Base.perform_caching
      Rails.cache.fetch("lcnaf-#{lcnaf_uri.to_s}", :expires_in => 1.week) do
        fetch_live_person_data(lcnaf_uri)
      end
    else
      Rails.logger.debug {"Bypassing cache for LD lcnaf lookup"}
      fetch_live_person_data(lcnaf_uri)
    end
  end

  def self.fetch_live_person_data(lcnaf_uri)
    begin
      ActiveSupport::Notifications.instrument("bibcard.person_data", uri: lcnaf_uri.to_s) do
        BibCard.person_data(lcnaf_uri)
      end
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      return nil
    end
  end


end
