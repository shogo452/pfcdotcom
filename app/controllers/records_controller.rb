class RecordsController < ApplicationController
  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to controller: "users", action: "show", id: current_user.id
      flash[:success] = "記録が完了しました。"
    else
      flash[:caution] = "日付と体重を入力してください" 
      redirect_to controller: "users", action: "show", id: current_user.id
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to controller: "users", action: "show", id: current_user.id
  end

  private

  def record_params
    params.require(:record).permit(:date, :weight, :body_fat_percentage, :prefecture_id).merge(user_id: current_user.id)
  end
end
