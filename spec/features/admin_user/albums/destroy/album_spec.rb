require 'spec_helper'

feature 'admin destroys album' do
  let!(:new_album) { create(:album, name: 'Album-1') }

  scenario do
    admin_session_sign_in

    click_on I18n.t('views.casein.layouts.tab_navigation.albums')
    click_on new_album.name
    click_on I18n.t('views.casein.albums.show.link.remove_album')

    expect(page).to have_content(I18n.t('flash.actions.destroy.notice'))
  end
end
