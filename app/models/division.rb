# == Schema Information
#
# Table name: divisions
#
#  id          :integer          not null, primary key
#  code        :integer
#  val         :integer
#  sort_order  :integer
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_divisions_on_code_and_val  (code,val) UNIQUE
#

class Division < ActiveRecord::Base
  has_many :division_locales, dependent: :destroy
  has_many :projects

  accepts_nested_attributes_for :division_locales, allow_destroy: true

  validates :code, presence: true
  validates :val, presence: true, uniqueness: { scope: :code }

  def name(locale)
    division_locales.localed(locale).name
  end

  def get_or_new_locale(language_id)
    dl = division_locales.find { |r| r.language_id == language_id }
    dl = division_locales.langed(language_id) if dl.blank?
    dl = division_locales.build(language_id: language_id) if dl.blank?
    dl
  end

  CODES = { project_status: 2 }
  VALS = { project_status: { draft: 1, applied: 2, active: 5, closed: 9 } }

  def self.div(code, val)
    c = CODES[code]
    v = VALS[code][val]
    Division.where(code: c, val: v).first
  end
end