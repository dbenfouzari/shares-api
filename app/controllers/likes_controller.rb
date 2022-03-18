class LikesController < ApplicationController
  include Behaveable::ResourceFinder
  include Behaveable::RouteExtractor

  # GET /likes
  def index
    likeables = likable.all

    render json: likeables, status: :ok, location: extract(@behaveable)
  end

  # POST /likes
  def create
    like = likable.new(like_params)

    like.transaction do
      if like.save
        likable << like if @behaveable

        render json: like, status: :created, location: extract(@behaveable, like)
      else
        render json: like.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /likes/1
  def destroy
    like = likable.find(params[:id])
    like.destroy if like

    head :no_content
  end

  private
    def likable
      @behaveable ||= behaveable
      @behaveable ? @behaveable.likes : Like
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:likable_id, :likable_type, :user_id)
    end
end
