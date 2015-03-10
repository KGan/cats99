class Cat < ActiveRecord::Base
  COLORS = [:red, :blue, :green, :yellow, :pink, :purple].map(&:to_s)
  SEXES = ['M', 'F']
  validates_presence_of :birth_date, :color, :name, :sex
  validates :color, inclusion: {in: COLORS}
  validates :sex, inclusion: {in: SEXES}
  has_many(
    :cat_rental_requests, dependent: :destroy
  )


  def age
    Time.now.year - birth_date.year
  end



end
