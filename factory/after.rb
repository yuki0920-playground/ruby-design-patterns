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
  def initialize(water, milk)
    @protein = ProteinCreator.create(water, milk)
  end

  def execute
    @protein.prepare
  end
end

class ProteinCreator
  def self.create(water, milk)
    if water && !milk
      WheyProtein.new
    elsif !water && milk
      SoyProtein.new
    end
  end
end

whey_protein_preparer = ProteinPreparer.new(true, false)
whey_protein_preparer.execute
soy_protein_preparer = ProteinPreparer.new(false, true)
soy_protein_preparer.execute
