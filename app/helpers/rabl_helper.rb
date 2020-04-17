def generate_url(attachement)
    Rails.application.routes.url_helpers.rails_blob_path(attachement, only_path: true)
end