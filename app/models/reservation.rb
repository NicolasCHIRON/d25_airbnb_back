class Reservation < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_must_be_before_end_time
  validate :overlaping_reservation?

  belongs_to :guest, class_name: "User"
  belongs_to :accomodation

  def start_must_be_before_end_time
    errors.add(:start_date, "must be before end time") unless
      start_date < end_date
  end

  def duration
    return (end_date - start_date).to_i
  end

  def overlaping_reservation?
    return if self
      .class
      .where.not(id: id)
      .where(accomodation_id: accomodation_id)
      .where('start_date < ? AND end_date > ?', end_date, start_date)
      .none?

    errors.add(:base, 'Overlaping reservation exists')
  end

end
