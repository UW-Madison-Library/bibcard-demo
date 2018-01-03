module AuthorsHelper

  def parse_date(datestr)
    begin
      datestr.match(/^-*\d{1,4}-\d{1,2}-\d{1,2}$/) ? Date.parse(datestr).strftime("%B %-d, %Y") : datestr
    rescue
      datestr
    end
  end

  def quick_facts?
    !@person.birth_date.nil? or
    !@person.death_date.nil? or
    (has_wikidata_work_location? or has_alma_maters?)
  end

  def displayable?
    has_getty_scope_note? or
    has_relevant_wikidata? or
    has_relevant_dbpedia?
  end

  def has_relevant_wikidata?
    has_wikidata_description or
    has_noteable_works? or
    has_wikidata_work_location? or
    has_alma_maters?
  end

  def has_relevant_dbpedia?
    has_dbpedia_abstract? or
    has_film_appearances? or
    has_influences? or
    has_influencees?
  end

  def has_getty_scope_note?
    @person && @person.getty_uri and @person.getty_subject.scope_note
  end

  def has_dbpedia_thumbnail?
    @person && @person.dbpedia_resource && @person.dbpedia_resource.thumbnail
  end

  def has_dbpedia_abstract?
    @person && @person.dbpedia_uri and @person.dbpedia_resource.abstract
  end

  def has_alma_maters?
    @person && @person.wikidata_entity && @person.wikidata_entity.alma_maters.size > 0
  end

  def has_influences?
    @person && @person.dbpedia_resource.influences.size > 0
  end

  def has_influencees?
    @person && @person.dbpedia_resource.influencees.size > 0
  end

  def has_film_appearances?
    @person && @person.dbpedia_uri && @person.dbpedia_resource.film_appearances.size > 0
  end

  def has_noteable_works?
    @person && @person.wikidata_uri && @person.wikidata_entity.notable_works.size > 0
  end

  def intellectual_network?
    @person && @person.dbpedia_uri && (has_influences? || has_influencees?)
  end

  def has_wikidata_entry?
    @person && @person.wikidata_entity && has_alma_maters?
  end

  def has_wikidata_description?
    @person && @person.wikidata_uri && @person.wikidata_entity.description
  end

  def has_wikidata_work_location?
    @person && @person.wikidata_uri && @person.wikidata_entity.work_location
  end

end
