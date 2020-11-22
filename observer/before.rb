require 'date'

class User
  def initialize(name, start_at = Date.today, retire_at = Date.today)
    @name = name
    @start_at = start_at
    @retire_at = retire_at
  end

  def send_sign_up_mail
    puts "何かしらの会員登録処理"
    puts "メール送信処理(#{@name}は #{@start_at} に登録しました。)"
  end

  def send_retire_mail
    puts "何かしらの会員退会処理"
    puts "メール送信処理(#{@name}は #{@retire_at} に退会しました。)"
  end
end

user = User.new('ユーザー')
user.send_sign_up_mail
user.send_retire_mail
