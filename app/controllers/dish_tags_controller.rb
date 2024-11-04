class DishTagsController < ApplicationController

  def create
    @dish = Dish.find(params[:dish_id])
    @dish_tags = DishTag.build(params.require(:dish_tag).permit(:dish_id, :tag_id))

    render @dish
  end
  
end