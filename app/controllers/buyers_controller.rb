class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_to_root_path, only: [:index, :create]

  def index
    @form_obj = FormObj.new
  end

  def create
    @form_obj = FormObj.new(obj_params)
    if @form_obj.valid?
      pay_item
      @form_obj.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def obj_params
    params.require(:form_obj).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: obj_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_to_root_path
    redirect_to root_path if (current_user == @item.user) || @item.buyer.present?
  end

end
