class ItemsController < ApplicationController

  def index
    @items = Item.all
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image,:name,:description,:category_id,:state_id,:postage_id,:prefecture_id,:shipping_date_id,:price).merge(user_id: current_user.id)
  end
end
