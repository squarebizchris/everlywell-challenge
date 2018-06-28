class MembersController < ApplicationController
  def new
    @member = Member.new
  end

  def show
    @member = Member.find(params[:id])
  end

  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to root_path }
      else
        format.html { redirect_to new_member_path(@member.id), notice: "Error" }
      end
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :url, :short_url)
  end
end
