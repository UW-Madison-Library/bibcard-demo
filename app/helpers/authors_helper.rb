module AuthorsHelper

  def parse_date(datestr)
    begin
      datestr.match(/^-*\d{1,4}-\d{1,2}-\d{1,2}$/) ? Date.parse(datestr).strftime("%B %-d, %Y") : datestr
    rescue
      datestr
    end
  end

  def quick_facts?(person)
    !person.birth_date.nil? or
    !person.death_date.nil? or
    (person.wikidata_uri and
      (
        person.wikidata_entity.work_location or
        person.wikidata_entity.alma_maters.size > 0
      )
    )
  end

  def displayable?(person)
    (person.getty_uri and person.getty_subject.scope_note) or
    (person.wikidata_uri and (
      person.wikidata_entity.description or
      person.wikidata_entity.notable_works.size > 0 or
      person.wikidata_entity.work_location or
      person.wikidata_entity.alma_maters.size > 0
    )) or
    (person.dbpedia_uri and
      (
        person.dbpedia_resource.abstract or
        person.dbpedia_resource.film_appearances.size > 0 or
        person.dbpedia_resource.influences.size > 0 or
        person.dbpedia_resource.influences.size > 0
      )
    )
  end

end
