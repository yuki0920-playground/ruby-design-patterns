# Rubyによるデザインパターン テンプレートメソッドパターン
プログラムの設計力向上のため『Rubyによるデザインパターン』を読んでおり、気になるデザインパターンを、1つずつまとめていきます。

今回は、テンプレートメソッドパターンについてまとめました。

## テンプレートメソッドパターンについて
基底クラスに不変の部分を記述し、変わる部分はサブクラスに定義するメソッドにカプセル化するパターンです。

変わるものと変わらないものを分離する、という設計の考えに基づいています。
## サンプルコード

趣味の筋トレにちなんでサンプルコードを書きます。
ベンチプレスと懸垂はどちらもトレーニングの流れは同じものの、具体的な流れはそれぞれ異なっています。

そこで、トレーニングごとの内容を出力するプログラムを書きます。

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
      puts 'ベンチプレスを始めます'
      puts 'バーベルをセットします'
    elsif @type == :tinning
      puts '懸垂を始めます'
      puts '踏み台に乗ります'
    end
  end

  def execute
    puts 'トレーニングをします'
  end

  def cleanup
    puts 'アルコール消毒します'
    if @type == :bench_press
      puts 'バーベルを戻します'
    elsif @type == :tinning
      puts '踏み台から降ります'
    end
  end
end
```

呼び出し時は引数にトレーニングの種類を渡します。
実行結果はこのとおりです。

```bash
bench_press = Training.new(:bench_press)
bench_press.start
# ベンチプレスを始めます
# バーベルをセットします
# トレーニングをします
# アルコール消毒します
# バーベルを戻します

tinning = Training.new(:tinning)
tinning.start
# 懸垂を始めます
# 踏み台に乗ります
# トレーニングをします
# アルコール消毒します
# 踏み台から降ります
```

インスタンス変数 @type によって if 分で分岐をしています。トレーニングが2種類ならばよいかもしれませんが、トレーニング数が増えるたびにこの条件分岐は増え、1つのメソッドは長く複雑になってしまいます。

次に Template Method パターンを適用して書き換えた場合です。

```rb
class Training
  def start
    prepare
    execute
    cleanup
  end

  def prepare
  end

  def execute
    puts 'トレーニングをします'
  end

  def cleanup
    puts 'アルコール消毒します'
  end
end

class BenchPress < Training
  def prepare
    puts 'ベンチプレスを始めます'
    puts 'バーベルをセットします'
  end

  def cleanup
    puts 'バーベルを戻します'
    super
  end
end

class Tinning < Training
  def prepare
    puts '懸垂を始めます'
    puts '踏み台に乗ります'
  end

  def cleanup
    super
    puts '踏み台から降ります'
  end
end
```

呼び出し時はサブクラスのインスタンスを生成しており、テンプレートメソッドパターン適用前はトレーニングの種目を引数で渡していましたが、それがなくなっています。
実行結果はこのとおりです。

```bash
bench_press = BenchPress.new
bench_press.start
# ベンチプレスを始めます
# バーベルをセットします
# トレーニングをします
# アルコール消毒します
# バーベルを戻します


tinning = Tinning.new
tinning.start
# 懸垂を始めます
# 踏み台に乗ります
# トレーニングをします
# アルコール消毒します
# 踏み台から降ります
```

基底クラス Training にはトレーニングの骨子だけを定義し、具体的なトレーニングの内容はサブクラスで定義しています。

新たにサブクラスを生成する必要になったときは、基底クラスは変えずにサブクラスだけを変えれば良くなり、変更に強くなりました。

## まとめ
テンプレートメソッドパターンは、継承を使ったオブジェクト指向らしいデザインパターンでした。

個人的にはデザインパターンの中で一番使用頻度が高いのではと思いますので、使いこなせるようになりたいです。
