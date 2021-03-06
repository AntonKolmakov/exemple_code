class UserFormField < ActiveRecord::Base
  TYPES = { TextField: 'Текстовое поле', CheckBox: 'Флажки',
            StaticText: 'Обычный текст', RadioButton: 'Радиокнопки' }
  TYPES_WHICH_NEEDS_VALUES = %i(CheckBox RadioButton)

  store :settings, accessors: %i(label input_class placeholder help), coder: JSON

  belongs_to :user_form, inverse_of: :user_form_fields
  has_many :available_values, -> { order :position }, class_name: 'UserFormFieldValue', dependent: :destroy

  validates :type, presence: true, inclusion: { in: TYPES.keys.map(&:to_s) }

  scope :admin_table_showable, -> { where show_in_admin_table: true }

  accepts_nested_attributes_for :available_values, allow_destroy: true

  acts_as_list scope: :user_form

  def needs_values?
    persisted? && TYPES_WHICH_NEEDS_VALUES.include?(type.to_sym)
  end

  def formatted_value(field_value)
    field_value
  end
end
