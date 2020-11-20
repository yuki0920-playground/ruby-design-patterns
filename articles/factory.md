#【Rubyによるデザインパターン】ファクトリーメソッドパターンのメモ

プログラムの設計力向上のため『Rubyによるデザインパターン』を読んでおり、気になるデザインパターンを、1つずつまとめています。

今回は、ファクトリーメソッドパターンについてまとめました。

## ファクトリーメソッドパターンについて
オブジェクトの生成をするメソッド、クラスを定義するパターンです。

Factory(Creator) というクラスを定義し、Factory がクラスを選択しオブジェクト生成を担います。

## サンプルコード
毎日愛飲しているプロテインを題材にサンプルコードを書きます。
僕の場合、プロテインの種類によって準備工程が異なるので、プロテインの準備工程を出力するプログラムを書きます。

まずはファクトリーメソッドパターン適用前からです。

```rb
class WheyProtein
  def initialize
    @name = 'ホエイプロテイン'
  end

  def add_water
    puts "#{@name}: 水を入れます"
  end


  def shake
    puts "#{@name}: 10回シェイクします"
  end
end

class SoyProtein
  def initialize
    @name = 'ソイプロテイン'
  end

  def add_milk
    puts "#{@name}: 牛乳を入れます"
  end

  def shake
    puts "#{@name}: 20回シェイクします"
  end
end

class ProteinPreparer
  def initialize(water, milk)
    @protein =
      if water && !milk
        WheyProtein.new
      elsif !water && milk
        SoyProtein.new
      end
  end

  def execute
    if @protein.class == WheyProtein
      @protein.add_water
    elsif @protein.class == SoyProtein
      @protein.add_milk
    end
    @protein.shake
  end
end
```

実行時はこのとおりです。
```rb
whey_protein_preparer = ProteinPreparer.new(true, false)
whey_protein_preparer.execute
# ホエイプロテイン: 水を入れます
# ホエイプロテイン: 10回シェイクします

soy_protein_preparer = ProteinPreparer.new(false, true)
soy_protein_preparer.execute
# ソイプロテイン: 牛乳を入れます
# ソイプロテイン: 20回シェイクします
```

ProteinPreparer の問題は 2つの責務を担っている点です。

- initialize で、@protein のクラスを選択しオブジェクト生成
- execute で、準備工程の実行

本来 ProteinPreparer は準備工程の責務だけをもつクラスですので、クラスを選択しオブジェクト生成する責務は別クラスへ委譲したいところです。

そこで、ファクトリークラスを生成し、責務を分離することにします。
次は、ファクトリーメソッドパターンを適用して書き換えた場合です。


```rb
class WheyProtein
  def initialize
    @name = 'ホエイプロテイン'
  end

  def prepare
    add_water
    shake
  end

  def add_water
    puts "#{@name}: 水を入れます"
  end

  def shake
    puts "#{@name}: 10回シェイクします"
  end
end

class SoyProtein
  def initialize
    @name = 'ソイプロテイン'
  end

  def prepare
    add_milk
    shake
  end

  def add_milk
    puts "#{@name}: 牛乳を入れます"
  end

  def shake
    puts "#{@name}: 20回シェイクします"
  end
end

class ProteinPreparer
  def initialize(proteins)
    @protein = ProteinFactory.create(proteins)
  end

  def execute
    @protein.prepare
  end
end

class ProteinFactory
  def self.create(proteins)
    protein.new
  end
end

```

実行結果はこのとおりです。

```rb
whey_protein_preparer = ProteinPreparer.new(WheyProtein)
whey_protein_preparer.execute
# ホエイプロテイン: 水を入れます
# ホエイプロテイン: 10回シェイクします

soy_protein_preparer = ProteinPreparer.new(WheyProtein)
soy_protein_preparer.execute
# ソイプロテイン: 牛乳を入れます
# ソイプロテイン: 20回シェイクします
```

プロテインのオブジェクト生成用の ProteinFactory を定義しています。

これによって、オブジェクト生成の責務を ProteinPreparer から分離でき、コードの見通しが良くなったことがわかるのではいでしょうか。
今後プロテインの種類が増えた場合には、 ProteinPreparer の修正は不要で、 ProteinFactory のみを修正すれば良くなるのが嬉しいポイントですね。


## まとめ
ファクトリーメソッドパターンはオブジェクト生成だけを担うクラスを定義するパターンでした。
オブジェクトのバリエーションが多いような場合に特に活用できるパターンだと思います。
