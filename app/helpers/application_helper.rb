module ApplicationHelper
  attr_reader :show_title
  alias_method :show_title?, :show_title

  def title(page_title, show_title = false)
    @show_title = show_title
    content_for(:title) { page_title.to_s }
  end

  def render_form(form_alias)
    form = UserForm.find_by(alias: form_alias.to_s)

    render form.user_form_submissions.build if form
  end
end
