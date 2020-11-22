#【Rubyによるデザインパターン】オブザーバーパターンのメモ

プログラムの設計力向上のため『Rubyによるデザインパターン』を読んでおり、気になるデザインパターンを、1つずつまとめています。

今回は、オブザーバーパターンについてまとめました。

## オブザーバーパターンについて

## サンプルコード
どのようなWebサイトでも「会員」がいるケースが多いと思います。今回はこの会員の登録、退会時のメール送信処理をプログラムに書きます。

とはいえ、実際ににメール送信新処理を実装するのは大変なので、 puts で代用しています。

まずはオブザーバーパターン適用前からです。

```rb
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
```

実行時はこのとおりです。
```rb
user = User.new('ユーザー')
user.send_sign_up_mail
user.send_retire_mail
# ユーザーが登録しました
# 登録日は 2020-11-22 です
# ユーザーが退会しました
# 登録日は 2020-11-22 です
```

現在は、登録時、退会時のみにメール送信をしていますので、そこまで複雑ではないですが、他にも、会員情報が更新されたとき、などメール送信が必要な処理が増えるとたちまち User クラスが肥大化してしまいます。

次は、オブザーバーパターンを適用して書き換えた場合です。


```rb
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
```

実行結果はこのとおりです。

```rb
user = User.new('ユーザー')
user.sign_up
user.retire
# ユーザーが登録しました
# 登録日は 2020-11-22 です
# ユーザーが退会しました
# 登録日は 2020-11-22 です
```

メール送信処理を担う UserMailer を定義し、メール送信処理はすべて UserMailer を介して行うようにします。

言い換えると、UserMailer はメール送信イベントを監視し、メール送信イベントが発生した場合に、送信処理を行います。

今回のケースではメール送信のイベントが増えても、 User の処理には影響を与えないという点で、会員登録処理とメール送信処理を疎結合にできています。

## オブザーバーパターンの適用例

オブザーバーパターンは、イベントの監視をするクラスにイベント処理を集約するパターンです。

例えば、今回のメール送信処理は、Rails アプリケーションでは Mailer が組み込まれており、自ずと Mail送信処理を分離できるような設計となっています。

このようにRails の設計意図を理解しておくと、フレームワークに則った設計ができるようになりそうです。


## まとめ
オブザーバーパターンはイベント処理をドメインモデルから分離するというパターンでした。もともとRails でも取り入れられていることを知り、Railsの有用性を再認識しました。

普段何気なく使っているフレームワークの設計意図を知れるのも、デザインパターンを学ぶ意義の1つですね。
