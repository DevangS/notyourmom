class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_protected
  validates_presence_of :firstName, :lastName, :email, :password
  belongs_to :household
  has_many :expenses
  has_many :debts
  has_many :authentications, :dependent => :delete_all

  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = auth['extra']['raw_info']['email']
    # Again, saving token is optional. If you haven't created the column in
    #authentications table, this will fail
    authentications.build(:provider => auth['provider'], :uid => auth['uid'],
      :token => auth['credentials']['token'])
  end

  def full_name
    [firstName, lastName].join(' ')
  end

  def full_name=(name)
    split = name.split(' ', 2)
    self.firstName = split.first
    self.lastName = split.last
  end

  def join_household(household)
    self.household_id = household.id
    return self
  end

  def leave_household
    self.household_id = nil
    return self
  end

  def is_head_of_house
    Household.find(self.household_id).head_id == self.id
  end

end
