module Admin
  class UserFormsController < Admin::ApplicationController
    expose(:user_forms) { UserForm.all }
    expose(:user_form)

    def index
    end

    def edit
    end

    def new
      user_form.user_form_fields.build
    end

    def create
      user_form.save
      respond_with :admin, user_form, location: -> { edit_admin_user_form_path(user_form) }
    end

    def update
      user_form.update(user_form_params)
      respond_with :admin, user_form, location: -> { edit_admin_user_form_path(user_form) }
    end

    def destroy
      user_form.destroy
      respond_with(:admin, :user_forms)
    end

    private

    def user_form_params
      params.require(:user_form).permit(:name,
        :email,
        :page_id,
        :alias).merge(user_form_fields_attributes)
    end

    def user_form_fields_attributes
      params.require(:user_form).permit(user_form_fields_attributes: [
        :id,    :_destroy,    :position,
        :label, :static_text, :name,
        :type,  :required,    :show_in_admin_table,
        available_values_attributes: %i(id value _destroy position)])
    end
  end
end
