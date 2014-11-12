module ImportProductionSiteData
  class BackupCurrent
    include Interactor::Organizer

    before do
      context.local_file_path = "#{Rails.root}/tmp/backup-json-data"
      context.fail! unless context.model
    end

    organize ::WriteFile
  end
end
