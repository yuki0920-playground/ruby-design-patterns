#【Rubyによるデザインパターン】オブザーバーパターンのメモ

プログラムの設計力向上のため『Rubyによるデザインパターン』を読んでおり、気になるデザインパターンを、1つずつまとめています。

今回は、オブザーバーパターンについてまとめました。

## オブザーバーパターンについて
何らかのオブジェクトの状態が変化したとき(イベントが発生した時)に、依存関係にあるすべてのオブジェクトに自動的にその変化をその変化を通知するパターンです。

ここで、状態が変化するオブジェクトを持つクラスを Subject、状態変化を検知するクラスを Observer として定義します。

## サンプルコード
どのようなWebサイトでも「会員」がいるケースが多いと思います。今回はこの会員の登録、退会時のメール送信処理想定します。

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
```

実行時はこのとおりです。
```rb
user = User.new('ユーザー')
user.send_sign_up_mail
user.send_retire_mail
# 何かしらの会員登録処理
# メール送信処理(ユーザーは 2020-11-22 に登録しました。)
# 何かしらの会員退会処理
# メール送信処理(ユーザーは 2020-11-22 に退会しました。)
```

登録時、退会時のみにメール送信をしていますので、そこまで複雑ではないですが、他にも、会員情報が更新されたときなどメール送信が必要な処理が増えると、たちまち User クラスが肥大化してしまいます。

ユーザーの登録/退会処理とメール送信処理が同じクラス内に含まれており、複雑になるのが問題となりやすいです。

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
```

実行結果はこのとおりです。

```rb

user = User.new('ユーザー')
user.sign_up
user.retire
# 何かしらの会員登録処理
# メール送信処理(ユーザーは 2020-11-22 に登録しました。)
# 何かしらの会員退会処理
# メール送信処理(ユーザーは 2020-11-22 に退会しました。)
```

メール送信の責務を担う UserMailer を定義し、メール送信処理はすべて UserMailer を介して行うようにします。

ここで UserMailer は Observer として Subject である User から送られているメール送信イベントを監視します。

今回のケースではメール送信のイベントが増えても、 User の処理には影響を与えないという点で、会員登録処理とメール送信処理を疎結合にできています。

## オブザーバーパターンの適用例


サンプルコードの今回のメール送信処理は、Rails においては ActionMailer が組み込まれており、おのずとと メール信処理を分離できるような設計となっています。

他にも、 Active Record は after_create や after_update はオブジェクトの作成やオブジェクトの更新を検知できる便利なコールバック用のメソッドを備えています。

このようにRails には オブザーバーパターンを反映した設計がいくつもあることがわかります。

## まとめ
オブザーバーパターンはイベント処理を分離するというパターンです。もともとRails でも取り入れられていることを知り、Railsの有用性を再認識しました。

普段何気なく使っているフレームワークの設計意図を知れるのも、デザインパターンを学ぶ意義の1つですね。
