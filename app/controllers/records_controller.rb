class RecordsController < ApplicationController
  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to controller: "users", action: "show", id: current_user.id
    else
      redirect_to controller: "users", action: "show", id: current_user.id
    end
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    @record.update(record_params)
    redirect_to controller: "users", action: "show", id: current_user.id
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to controller: "users", action: "show", id: current_user.id
  end

  private

  def record_params
    params.require(:record).permit(:date, :weight, :body_fat_percentage).merge(user_id: current_user.id)
  end
  
end
