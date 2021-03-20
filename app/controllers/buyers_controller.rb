class BuyersController < ApplicationController
  
  def index
    @form_obj = FormObj.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @form_obj = FormObj.new(obj_params)
    if @form_obj.valid?
      @form_obj.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def obj_params
    params.require(:form_obj).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number, :buyer_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
