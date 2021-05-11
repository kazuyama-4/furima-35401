class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_item, except: %i[index new create]
  before_action :move_to_index, only: %i[edit update destroy]
  
  def index
    @items = Item.includes(:user).order('created_at DESC')
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

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:image, :product_name, :description, :category_id, :status_id, :charge_id, :prefecture_id,
                                 :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index if current_user.id != @item.user_id
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
