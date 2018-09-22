class ListsController < ApplicationController
  def create
    List.create(name: params[:name])
  end
end