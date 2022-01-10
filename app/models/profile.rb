class Profile < ApplicationRecord
    has_many(:educations, dependent: :destroy)
    accepts_nested_attributes_for(:educations , reject_if: :reject_education_create, allow_destroy: true)

    belongs_to :user
    has_one_attached :image
    validates :image, attached: true,
                      content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size: { less_than: 5.megabytes,
                              message:   "should be less than 5MB" }

    def display_image
        if image.attached?
            return image.variant(resize_to_limit: [500, 500])
        end
    end

    def reject_education_create(education)
        education[:degree].blank? or education[:school].blank? or education[:start].blank? or education[:end].blank?
    end

end