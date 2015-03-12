# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date
#  color       :string
#  name        :string
#  sex         :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          default("0"), not null
#

class Cat < ActiveRecord::Base
  COLORS = [:red, :blue, :green, :yellow, :pink, :purple].map(&:to_s)
  SEXES = ['M', 'F']
  validates_presence_of :birth_date, :color, :name, :sex
  validates :color, inclusion: {in: COLORS}
  validates :sex, inclusion: {in: SEXES}
  has_many(
    :cat_rental_requests, dependent: :destroy
  )
  belongs_to :user

  def age
    Time.now.year - birth_date.year
  end



end
