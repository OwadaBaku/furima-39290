class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @item = Item.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
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
    @item = Item.find(params[:id])

    if @item.user != current_user
      redirect_to root_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path, notice: '変更が完了しました。'
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_description, :category_id, :item_condition_id, :item_postage_id,
                                 :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
