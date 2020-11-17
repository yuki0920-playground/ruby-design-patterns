# 【Rubyによるデザインパターン】ストラテジーパターンのメモ

プログラムの設計力向上のため『Rubyによるデザインパターン』を読んでおり、気になるデザインパターンを、1つずつまとめていきます。

今回は、ストラテジーパターンについてまとめました。

## ストラテジーパターンについて
委譲をベースにした、複数の処理のバリエーションをを実装するためのデザインパターンです。

継承を使いサブクラスごとにバリエーションを実装する実装するテンプレートメソッドパターンと異なり、ストラテジーパターンはバリエーションごとにばらばらのクラスを生成します。

## サンプルコード

趣味の筋トレにちなんでサンプルコードを書きます。
(テンプレートメソッドパターンの記事との類似した例を題材としています。)

ベンチプレスと懸垂はどちらもトレーニングの内容は同じものの、具体的な内容はそれぞれ異なっています。

そこで、トレーニングごとの内容を出力するプログラムを書きます。

ストラテジーパターン適用前はこのとおりです。

```rb
class Training
  def initialize(type)
    @type = type
  end

  def start
    prepare
    execute
    cleanup
  end

  def prepare
    if @type == :bench_press
      puts 'バーベルをセットします'
    end
  end

  def execute
    puts 'トレーニングをします'
  end

  def cleanup
    puts 'アルコール消毒します'
    if @type == :bench_press
      puts 'バーベルを戻します'
    end
  end
end
```

呼び出し時は引数にトレーニングの種類を渡します。
実行結果はこのとおりです。

```rb
bench_press = Training.new(:bench_press)
bench_press.start
# バーベルをセットします
# トレーニングをします
# アルコール消毒します
# バーベルを戻します

tinning = Training.new(:tinning)
tinning.start
# トレーニングをします
# アルコール消毒します
# バーベルを戻します
```

インスタンス変数 @type によって if 分で分岐をしています。トレーニングが2種類ならばよいかもしれませんが、トレーニング数が増えるたびにこの条件分岐は増え、1つのメソッドは長く複雑になってしまいます。

また、 @type が :tinning のときは、 prepare が呼び出されているにも関わらず何も実行されていません。
これは、@type が :bench_press と :tinning で同じインターフェース(つまり、パブリックメソッド)である start を共有しているからです。

次に、ストラテジーパターンを適用して書き換えた場合です。

```rb
class Training
  def initialize(training_menu)
    @training_menu = training_menu
  end

  def start
    @training_menu.start
  end
end

class BenchPress
  def start
    prepare
    execute
    cleanup
  end

  def prepare
    puts 'バーベルをセットします'
  end

  def execute
    puts 'トレーニングをします'
  end


  def cleanup
    puts 'アルコール消毒します'
    puts 'バーベルを戻します'
  end
end

class Tinning
  def start
    execute
    cleanup
  end

  def execute
    puts 'トレーニングをします'
  end

  def cleanup
    puts 'アルコール消毒します'
  end
end
```
呼び出し時はトレーニングのバリエーションごとのオブジェクトを生成し、 Training 初期化時に渡します。

```rb
bench_press = BenchPress.new
training = Training.new(bench_press)
training.start
# バーベルをセットします
# トレーニングをします
# アルコール消毒します
# バーベルを戻します

tinning = Tinning.new
training = Training.new(tinning)
training.start
# トレーニングをします
# アルコール消毒します
# バーベルを戻します
```

BenchPress と Tinning で同じ start というインターフェースを持ちつつも、処理の内容が異なることがおわかりいただけるかと思います。
このように、処理の内容のを個々のオブジェクトに委ねられるため変更に強くなります。

## テンプレートメソッドパターンとの比較
ストラテジーパターンはテンプレートメソッドパターンに似ているのも特徴ですね。
テンプレートメソッドパターンは継承を使うため、基底クラスの処理内容を生かしてサブクラスを実装します。基底クラスの処理内容に変更がない場合、実装するコードは少なくできる反面、サブクラスは基底クラスの処理内容に依存しているため基底クラスは変更しづらくなります。

ストラテジーパターンは処理内容自体をオブジェクトに委譲できる点がメリットが大きいです。
テンプレートメソッドパターンとストラテジーパターンどちらを使うか迷った場合は、基本の処理内容が同じ場合はテンプレートメソッドパターン、処理内容のバリエーションが幅広い場合はストラテジーパターンが良さそうです。


## まとめ
ストラテジーパターンはポリモーフィズムを使ったオブジェクト指向らしいデザインパターンです。

テンプレートメソッドパターンと合わせてストラテジーパターンも使いこなせるようになりたいです。
