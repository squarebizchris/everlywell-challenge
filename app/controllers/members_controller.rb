class MembersController < ApplicationController
  def new
    @member = Member.new
  end

  def show
    @member = Member.find(params[:id])
    @headings = @member.headings
    @friends = @member.friends
    # Get all members not friends and self
    excluded_members = @friends.map(&:id).concat [params[:id]]
    @all_members = Member.where.not(id: excluded_members)
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

  def make_friendship
    @member = Member.find(params[:id])
    @friendship = @member.friendships.build(friend_id: params[:friend_id])
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to member_path(@member.id), notice: "Added friend." }
      else
        format.html { redirect_to member_path(@member.id), notice: "Error" }
      end
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :url, :short_url)
  end
end
