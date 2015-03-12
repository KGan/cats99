# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  session_token :string           not null
#  environment   :string
#  location      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Session < ActiveRecord::Base
  belongs_to :user
  after_initialize :set_token

  private
    def set_token
      self.session_token ||= SecureRandom.urlsafe_base64
    end
end
