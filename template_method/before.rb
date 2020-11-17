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


bench_press = Training.new(:bench_press)
bench_press.start

tinning = Training.new(:tinning)
tinning.start
