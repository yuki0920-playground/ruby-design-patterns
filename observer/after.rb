require 'date'

class User
  attr_reader :name, :start_at, :retire_at

  def initialize(name, start_at = Date.today, retire_at = Date.today)
    @name = name
    @start_at = start_at
    @retire_at = retire_at
  end

  def sign_up
    puts "何かしらの会員登録処理"
    UserMailer.sign_up(self)
  end

  def retire
    puts "何かしらの会員退会処理"
    UserMailer.retire(self)
  end
end

class UserMailer
  def self.sign_up(user)
    puts "メール送信処理(#{user.name}は #{user.start_at} に登録しました。)"
  end

  def self.retire(user)
    puts "メール送信処理(#{user.name}は #{user.retire_at} に退会しました。)"
  end
end

user = User.new('ユーザー')
user.sign_up
user.retire
