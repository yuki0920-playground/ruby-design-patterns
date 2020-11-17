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

bench_press = BenchPress.new
bench_press.start

tinning = Tinning.new
tinning.start
