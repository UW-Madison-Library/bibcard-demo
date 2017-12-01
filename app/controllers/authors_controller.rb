class AuthorsController < ApplicationController

  def view
    @person = LinkedData.lcnaf_person(params[:lcnafid])

    # TODO: Should only render 200 success if @person exists and person is
    # displayable. Render "no content" if person was found but there is nothing
    # to show? This would make status checking easier & faster...??
    # Can't really do "no content" because then we couldn't have a layout...
    render layout: !request.xhr?
  end

end
