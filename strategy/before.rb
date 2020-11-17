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


bench_press = Training.new(:bench_press)
bench_press.start

tinning = Training.new(:tinning)
tinning.start
