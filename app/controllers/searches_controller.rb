class SearchesController < ApplicationController
  def index
    @model = params[:model]
    @word = params[:word]

    if @model == "User"
      @result = User.looks(params[:word])
    else
      @result = PostEvent.looks(params[:word])
    end
  end
end
