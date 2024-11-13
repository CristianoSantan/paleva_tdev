class TagsController < ApplicationController
  before_action :authenticated

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params.require(:tag).permit(:name, :establishment_id))
    if @tag.save
      redirect_to current_establishment, notice: "Marcador cadastrado com sucesso."
    else
      flash[:alert] = "Marcador não cadastrado."
      render 'new'
    end
  end
end