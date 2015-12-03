class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :conta, autosave: true

  before_create :criar_conta

  accepts_nested_attributes_for :conta

  delegate :saldo, :id, to: :conta, prefix: true, allow_nil: true

  ## Código copiado de https://github.com/plataformatec/devise/wiki/How-to:-Soft-delete-a-user-when-user-deletes-account
  # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end  

  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at  
  end  

  # provide a custom message for a deleted account   
  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end  

  private
    def criar_conta
      self.build_conta({ saldo: 0 })
      build_conta({ saldo: 0 })
    end
end
