class CatRentalRequest < ActiveRecord::Base
  validates_presence_of :cat_id, :start_date, :end_date
  validates :status, inclusion: {in: ["PENDING", "DENIED", "APPROVED"]}
  validate :overlapping_approved_requests, on: [:create, :approve!, :save]
  belongs_to :cat
  after_initialize :init

  def overlapping_requests
    CatRentalRequest.where("((start_date BETWEEN :start_date AND :end_date) OR (end_date BETWEEN :start_date AND :end_date)) AND id != :id",
                            :start_date => self.start_date,
                            :end_date => self.end_date,
                            :id => self.cat_id
                            )
  end

  def overlapping_approved_requests
    if overlapping_requests.where(status: "APPROVED").any?
      errors[:overlap] = "Sorry, #{self.cat.name} can't be booked for this time."
    end
  end

  def init
    self.status ||= "PENDING"
  end

  def approve!
    CatRentalRequest.transaction do
      self.update!(:status => 'APPROVED')
      self.overlapping_requests.where(status: "PENDING").each do |request|
        request.deny!
      end
    end
  end

  def deny!
    CatRentalRequest.transaction do
      self.update!(:status => "DENIED")
    end
  end
end
