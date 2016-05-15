class Product < ActiveRecord::Base
  include ProductDecorator
  UPDATABLE_ATTRS = %i(m_book_id rental_user_id status)
  belongs_to :m_book, class_name: M::Book.name
  has_many :borrowing_histories, dependent: :destroy

  def latest_borrowing_history
    borrowing_histories.last
  end

  def status
    history = latest_borrowing_history
    unless history.nil?
      history.returned_at.nil? ? :borrowed : :returned
    end
  end
end
