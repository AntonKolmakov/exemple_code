require 'spec_helper'

feature 'admin creates attachment', js: true do
  let!(:user_page) { create :page, description: 'description goes here...' }

  scenario do
    admin_session_sign_in

    click_on I18n.t('views.casein.layouts.tab_navigation.pages')
    click_on user_page.name
    attach_file('page_attachment[attachment]', File.expand_path('spec/fixtures/pages/attachments/документ.pdf'))

    expect(page).to have_content('dokument.pdf')
  end
end
