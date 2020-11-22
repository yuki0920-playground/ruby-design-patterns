require 'date'

class User
  attr_reader :name, :start_at, :retire_at

  def initialize(name, start_at = Date.today, retire_at = Date.today)
    @name = name
    @start_at = start_at
    @retire_at = retire_at
  end

  def sign_up
    UserMailer.sign_up(self)
  end

  def retire
    UserMailer.retire(self)
  end
end

class UserMailer
  def self.sign_up(user)
    puts "#{user.name}が登録しました"
    puts "登録日は #{user.start_at} です"
  end

  def self.retire(user)
    puts "#{user.name}が退会しました"
    puts "登録日は #{user.retire_at} です"
  end
end

user = User.new('ユーザー')
user.sign_up
user.retire
