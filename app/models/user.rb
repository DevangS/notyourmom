class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_protected
  validates_presence_of :firstName, :lastName, :email, :password
  #validates_presence_of :invitation_id, :message => 'is required'
  validates_uniqueness_of :invitation_id
  belongs_to :household
  has_many :expenses
  has_many :debts
  has_many :authentications, :dependent => :delete_all
  # Inviter
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  # Invitee
  belongs_to :invitation

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
    if self.household_id != nil
      Household.find(self.household_id).head_id == self.id
    else
      false
    end
  end

  def is_head_of(household)
    if self.household_id != nil
      household.head_id == self.id
    else
      false
    end
  end

  def asdfh(user)
    my_expenses = Expense.where(:user_id => self.id, :resolved => false).select(:id)
    debts_for_me = Debt.where(:paid => false, :user_id => user.id, :expense_id => my_expenses)
    #debts_for_me = Debt.where{paid == false and user_id == user.id and expense_id.like_any (my_expenses)}
    if debts_for_me then
      owed_to_me = debts_for_me.map { |debt| debt.get_share }.reduce(:+)
    else
      owed_to_me = 0
    end

    their_expenses = Expense.where(:user_id => user.id, :resolved => false)
    debts_by_me = their_expenses.map {|expense| expense.debts }.find{|debt| debt.first.user_id == self.id}
    if debts_by_me then
      owed_by_me = debts_by_me.map { |debt| debt.get_share }.reduce(:+)
    else
      owed_by_me = 0
    end
    owed_to_me - owed_by_me
  end

  def consolidated_debt_with(user)
    owed_by_me = first_owes_second(self, user)
    owed_to_me = first_owes_second(user, self)

    owed_to_me - owed_by_me
  end

  def first_owes_second(borrower,lender)
    expenses = Expense.where(:user_id => lender.id, :resolved => false).select(:id)
    debts = Debt.where(:paid => false, :user_id => borrower.id, :expense_id => expenses)
    if debts.count > 0
      #calculate owed
      debts.map { |debt| debt.get_share }.reduce(:+)
    else
      #default to 0
      0
    end
  end



end
