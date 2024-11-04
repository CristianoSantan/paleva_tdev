class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params.require(:tag).permit(:name, :establishment_id))
    if @tag.save
      redirect_to current_user.establishment, notice: "Marcador criado com sucesso."
    else
      flash[:alert] = "Marcados não cadastrado"
      render 'new'
    end
  end
  
end