class SearchesController < ApplicationController
  def index
    @model = params[:model]
    @word = params[:word]

    @result = if @model == "User"
                User.looks(params[:word])
              else
                PostEvent.looks(params[:word])
              end
  end
end
