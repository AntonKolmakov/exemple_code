# encoding: utf-8
class UserFormField < ActiveRecord::Base
  KINDS = { text: 'Текстовое поле', check_boxes: 'Флажки',
            hidden: 'Скрытое поле', radio_buttons: 'Радиокнопки' }
  KINDS_WHICH_NEEDS_VALUES = %i(check_boxes hidden radio_buttons)

  belongs_to :user_form
  has_many :available_values, class_name: 'UserFormFieldValue', dependent: :destroy

  validates :name, :field_type, presence: true
  validates :field_type, inclusion: { in: KINDS.keys.map(&:to_s) }

  scope :admin_table_showable, -> { where show_in_admin_table: true }

  accepts_nested_attributes_for :available_values, allow_destroy: true

  def needs_values?
    persisted? && KINDS_WHICH_NEEDS_VALUES.include?(field_type.to_sym)
  end
end
