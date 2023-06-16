class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @item = Item.order(created_at: :desc)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.image.attach(params[:item][:image])
    if @item.save
      redirect_to root_path, notice: '出品が完了しました。'
    else
      render :new
    end
  end

  def edit
    return unless @item.user != current_user

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path, notice: '変更が完了しました。'
    else
      render :edit
    end
  end

  def destroy
    if @item.user == current_user
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :item_name, :item_description, :category_id, :item_condition_id, :item_postage_id,
                                 :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end