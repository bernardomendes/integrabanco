class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :conta

  before_create :criar_conta


  delegate :saldo, :id, to: :conta, prefix: true


  private
    def criar_conta
      self.build_conta(saldo: 0)
    end
end
