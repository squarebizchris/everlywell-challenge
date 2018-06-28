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

    # Search Logic
    if !params[:search_string].blank?
      @search_results = []
      source_id = params[:root_member_id].to_i
      matched_headings = Heading.where("header_text ILIKE ?", "%#{params[:search_string]}%")
      matched_headings.each do |heading|
        # set result variables
        destination_id = heading.member_id
        heading_text = heading.header_text
        @search_results << search_for_match(source_id, destination_id, heading_text)
      end
      @search_results.compact!
    end
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

  def search_for_match(source_id, destination_id, heading_text)
    search_api = SearchAPI.new(source_id, destination_id)
    path = search_api.search
    if path.nil?
      search_result = { heading: heading_text, path: 'Friendship not found'}
    elsif path.length == 1
      search_result = nil
    else
      pathway = []
      path.map{|x| pathway << x.name}
      path_string = pathway.join(",").gsub(',',' -> ')
      search_result = { heading: heading_text, path: path_string}
    end
    search_result
  end

end
