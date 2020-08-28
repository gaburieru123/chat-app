class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user) #チャットルームに紐付いている全てのメッセージ（@room.messages）を@messagesと定義
    #一覧画面で表示するメッセージ情報には、ユーザー情報も紐付いて表示される
    #メッセージに紐付くユーザー情報の取得に、メッセージの数と同じ回数のアクセスが必要になるので、N+1問題が発生
    #メッセージ情報に紐づくユーザー情報を、includes(:user)と記述をすることにより、ユーザー情報を1度のアクセスでまとめて取得
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else#投稿に失敗したときの処理
      @messages = @room.messages.includes(:user)
      #renderを用いることで、投稿に失敗した@messageの情報を保持しつつindex.html.erbを参照することができます（この時、indexアクションは経由しません）
      #しかし、そのときに@messagesが定義されていないとエラーになる
      #そこで、indexアクションと同様に@messagesを定義する必要があり
      render :index
    end


  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
