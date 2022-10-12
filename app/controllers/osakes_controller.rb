class OsakesController < ApplicationController
  def show
    @osake = Osake.find(params[:id])
    @user = @osake.user
    @osake_new = Osake.new
    @post_comment = PostComment.new
  end

  def index
    @osake = Osake.new
    @osakes = Osake.all
  end

  def create
    @osake = Osake.new(osake_params)
    @osake.score = Language.get_data(osake_params[:body])  #この行を追加
    @osake.user_id = current_user.id
    if @osake.save
      redirect_to osake_path(@osake), notice: 'You have created osake successfully.'
    else
      @osakes = Osake.all
      render 'index'
    end
  end

  def edit
    @osake = Osake.find(params[:id])
    if current_user == @osake.user
      render :edit
    else
      redirect_to osakes_path
    end
  end

  def update
    @osake = Osake.find(params[:id])
    if @osake.update(osake_params)
      redirect_to osake_path(@osake), notice: 'You have updated osake successfully.'
    else
      flash[:alert] = ''
      render 'edit'
    end
  end

  def destroy
    @osake = Osake.find(params[:id])
    @osake.destroy
    redirect_to osakes_path
  end

  private

  def osake_params
    params.require(:osake).permit(:title, :body, :profile_image)
  end
end
