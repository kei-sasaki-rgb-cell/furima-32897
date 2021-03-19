class BuyersController < ApplicationController
  
  def index
    @form_obj = FormObj.new
    #@item = Item.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  def create
    binding.pry
  end

  private

  #def obj_params
    #params.require(:form_obj).permit(:user, :item, :postcode, :prefecture, :city, :block, :building, :phone_number)
  #end

end
