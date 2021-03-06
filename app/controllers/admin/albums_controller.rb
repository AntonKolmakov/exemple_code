module Admin
  class AlbumsController < Admin::ApplicationController
    expose(:albums) { Album.all }
    expose(:album, find_by: :slug)

    def index
    end

    def new
      album.build_seo_datum
    end

    def edit
      album.build_seo_datum unless album.seo_datum.present?
    end

    def create
      album.save
      respond_with :admin, album, location: -> { edit_admin_album_path(album) }
    end

    def update
      album.save
      respond_with :admin, album, location: -> { edit_admin_album_path(album) }
    end

    def destroy
      album.destroy
      respond_with :admin, album
    end

    private

    def album_params
      params.require(:album).permit(:name,
                                    :watermark,
                                    :description,
                                    :short_description,
                                    :slug,
                                    :fix_slug,
                                    seo_datum_attributes: %i(id meta_title meta_keywords meta_description seo_text))
    end
  end
end
