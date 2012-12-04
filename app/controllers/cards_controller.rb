class CardsController < ApplicationController
  include CardsHelper

  DEFAULT_PER_PAGE = 10
  def index
    @cards = Card.order(params[:order] || 'name').includes(:school_levels).includes(:pack_cards)
    @cards = @cards.send(:for_school, params[:for_school]) if params[:for_school]
    @cards = @cards.send(:for_type, params[:for_type]) if params[:for_type]

    unless params[:search].blank? 
      @cards = @cards.where("lower(name) like '%#{params[:search].downcase}%'")
    end

    @cards = @cards.paginate(page:(params[:page] || 1), per_page:(params[:per_page] || DEFAULT_PER_PAGE))

    respond_to do |format|
      format.html
      format.js
      format.json do 
        render :json => {
          :current_page => @cards.current_page,
          :per_page => @cards.per_page,
          :total_entries => @cards.total_entries,
          :entries => flatten_cards(@cards),
          :echo => params[:echo]
        }
      end
    end
  end

end
