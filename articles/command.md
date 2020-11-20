#【Rubyによるデザインパターン】コマンドパターンのメモ

プログラムの設計力向上のため『Rubyによるデザインパターン』を読んでおり、気になるデザインパターンを、1つずつまとめています。

今回は、コマンドパターンについてまとめました。

## コマンドパターンについて
特定の動作を実行するオブジェクト(コマンドオブジェクト)を定義し、そのオブジェクトを経由して動作を実行するパターンです。

複雑なロジックを分離したいときに使えるリファクタリングのテクニックとしても有用です。
分離後にはロジックをさらに分割する、変数名を修正するなどのさらなる改善が容易になり、コードの見通しが良くできることが特徴です。


## サンプルコード
私はジム通いしているのですが、その趣味にちなんで、ジムの月あたりの維持費用を計算するプログラムを考えます。

簡易的に、維持費用は家賃と設備コストだけと仮定しています。
また、設備コストは設備のグレードから算出しています。

まずはコマンドパターン適用前からです。

```rb
class Gym
  def initialize(estate, equipment)
    @estate = estate
    @equipment = equipment
  end

  def calculate_maintenance_cost
    equipment_cost =
      case @equipment[:grade]
      when 'small'
        10
      when 'middle'
        50
      when 'high'
        100
      end

    @estate[:rent] + equipment_cost
  end
end
```

実行時はこのとおりです。
不動産(estate)や設備(equipment)は本来はクラス化したほうが良いのでしょうが、簡易的にハッシュで定義します。

```rb
estate = { name: 'サンプル不動産ビルディング', rent: 30 }
equipment = { name: 'ベンチプレスマシーン', grade: 'middle'}
gym = Gym.new(estate, equipment)
puts gym.calculate_maintenance_cost
# 80
```

現状では Gym に 1つのメソッドしか定義されていないので、見通しが悪いわけではありませんが、通常モデルにはビジネスロジックが集約され複雑化することが往々にしてあるかと思います。

そこで、 `calculate_maintenance_cost` 内のロジックにコマンドパターンを適用しオブジェクト化します。

```rb
class Gym
  def initialize(estate, equipment)
    @estate = estate
    @equipment = equipment
  end

  def calculate_maintenance_cost
    MaintenanceCostCalculater.new(@estate[:rent], @equipment[:grade]).execute
  end
end

class MaintenanceCostCalculater
  def initialize(rent, equipment_grade)
    @rent = rent
    @equipment_grade = equipment_grade
  end

  def execute
    equipment_cost =
    case @equipment_grade
    when 'small'
      10
    when 'middle'
      50
    when 'high'
      100
    end

    @rent + equipment_cost
  end
end
```

```rb
estate = { name: 'サンプル不動産ビルディング', rent: 30 }
equipment = { name: 'ベンチプレスマシーン', grade: 'middle'}
gym = Gym.new(estate, equipment)
puts gym.calculate_maintenance_cost
# 80
```

`calculate_maintenance_cost` の内容を MaintenanceCostCalculater のオブジェクトを通して実行するように修正しました。

MaintenanceCostCalculater は維持費用計算に必要な値のみを属性として持つため、シンプルなクラスです。

## コマンドオブジェクトのメソッド名
『リファクタリング 第2版』によると、コマンドオブジェクトは、 execute や call, run といったメソッド名をつけるケースが多いようです。

これを知った私は、確かに業務上でこれらのメソッド名を見かける機会多く、実は普段から触れていたアプリケーションがコマンドパターンに倣っているケースが多かったのだと気づきました。

みなさんの携わっているアプリケーションでも、これらのメソッド名が使用されていた場合、もしかしたらコマンドパターンが適用されているかもしれません。

## まとめ
コマンドパターンは特定の動作だけを担うオブジェクトを構築するパターンでした。
複雑なロジックのリファクタリングに有用なため、使いこなせるようになりたいです。
