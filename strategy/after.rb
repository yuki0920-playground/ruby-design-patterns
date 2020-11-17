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

bench_press = BenchPress.new
training = Training.new(bench_press)
training.start

tinning = Tinning.new
training = Training.new(tinning)
training.start
