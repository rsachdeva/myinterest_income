class Investment < ActiveRecord::Base
  belongs_to :customer
  belongs_to :bank
  #callbacks explitic here to help with Bank using belongs_to
  before_update :bank_update
  before_create :bank_create

  def compound_interest_years
    apy = investment_apy/100
    calculated_result_partial = (1+apy)**investment_years
    (investment_amount*calculated_result_partial)-investment_amount
  end


  def average_interest_monthly
    interest_per_day = (compound_interest_years)/(investment_years*365)
    interest_per_day*30
  end

  #just for nested attributes; helpful for creating in new, updating in edit
  def bank=(name)
    @invest_bank_name=name
  end

  #just for nested attributes; helpful for reading in edit
  def bank
    if !((self.read_attribute(:bank_id)).nil?)
      b = Bank.find(self.read_attribute(:bank_id))
      b.name
    end
  end


  def bank_create
     b = Bank.new(:name => @invest_bank_name)
     b.save!
     #using investment belongs to bank
     self.write_attribute(:bank_id, b.id)
  end

  def bank_update
     b = @invest_bank_name
     b = Bank.find(self.read_attribute(:bank_id))
     b.name = @invest_bank_name
     b.save!
     #using investment belongs to bank
     self.write_attribute(:bank_id, b.id)
  end

end
