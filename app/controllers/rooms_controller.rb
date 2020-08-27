class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
  
  end

  def destroy
    room = Room.find(params[:id])#どのチャットルームを削除するのかを特定
    room.destroy #destroyアクションは、削除するだけなのでビューの表示は必要はありません。#そのため、インスタンス変数ではなく変数としてroomを定義し、destroyメソッドを使用
    redirect_to root_path #root（roomsのindex）にリダイレクト
  end
  private

  def room_params
    params.require(:room).permit(:name, user_ids:[])
  end
end
