class FavoritesController < ApplicationController
  def create
    osake=Osake.find(params[:osake_id])
    favorite =current_user.favorites.new(osake_id: osake.id)
    favorite.save
    redirect_to osake_path(osake)
  end

  def destroy
    osake=Osake.find(params[:osake_id])
    favorite= current_user.favorites.find_by(osake_id: osake.id)
    favorite.destroy
    redirect_to osake_path(osake)
  end
end
