require 'date'

class User
  def initialize(name, start_at = Date.today, retire_at = Date.today)
    @name = name
    @start_at = start_at
    @retire_at = retire_at
  end

  def send_sign_up_mail
    puts "#{@name}が登録しました"
    puts "登録日は #{@start_at} です"
  end

  def send_retire_mail
    puts "#{@name}が退会しました"
    puts "登録日は #{@retire_at} です"
  end
end

user = User.new('ユーザー')
user.send_sign_up_mail
user.send_retire_mail
