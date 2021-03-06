class Shortcut < ApplicationRecord
  include StringNormalizer

  belongs_to :user
  has_many :shortcut_labels, dependent: :destroy
  has_many :labels, through: :shortcut_labels

  scope :include_labels, -> { includes([:labels]) }
  scope :order_created_desc, -> { order(created_at: :desc) }

  before_validation do
    self.title = normalize_as_text(title)
  end

  validate :user_shortcut_count_within_limit
  validates :title, presence: true,
                    uniqueness: { scope: :user },
                    length: { maximum: 40 }

  private

  def user_shortcut_count_within_limit
    errors.add(:shortcuts, count: I18n.t("errors.message.exceed")) if user.shortcuts.size > 10
  end
end
