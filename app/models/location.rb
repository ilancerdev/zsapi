class Location < ActiveRecord::Base
  enum status: [:pending, :active, :locked]

  belongs_to :business
  belongs_to :greeting
  
  has_one :beacon
  has_one :subscription
  has_one :user, through: :business
  has_one :exit_campaign, through: :greeting, source: :campaign

  has_many :customers, through: :visits
  has_many :visits
  has_many :redemptions
  has_many :receipts, through: :redemptions
  
  has_and_belongs_to_many :campaigns

  accepts_nested_attributes_for :greeting, reject_if: proc { |a| a['welcome_message'].blank? || a['welcome_message'].nil? }
  accepts_nested_attributes_for :campaigns

  validates_presence_of :address, :city, :state, :zipcode
  validates_length_of :state, is: 2

  before_save { |l| l.title = l.address + " Location" if l.title.nil? }

  geocoded_by :full_address
  after_validation :geocode, on: [:create], if: Proc.new { |l| l.address.present? && l.address2 != 'ignore' }

  def full_address(params = {})
  	if params[:multiline]
  		params[:newline] ||= "<br>"

  		the_address = "#{address}" + params[:newline]
  		the_address += "#{address2}" + params[:newline] unless address2.blank?
  	else
  		the_address = "#{address}, "
  		the_address += "#{address2}, " unless address2.blank?
  	end

		the_address += "#{city}, #{state} #{zipcode}"
		the_address
  end

  def full_address_changed?
    address_changed? || city_changed? || state_changed? || zipcode_changed?
  end

end
