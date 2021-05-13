class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_item, only: %i[index create]

  def index
    @order = Order.new
    redirect_to root_path if current_user.id == @item.user_id || @item.purchase.present?
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal, :prefecture_id, :city, :house_number, :building_name, :call_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(params[:item_id])[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
