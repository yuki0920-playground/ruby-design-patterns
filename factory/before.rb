class WheyProtein
  def initialize
    @name = 'ホエイプロテイン'
  end

  def add_water
    puts "#{@name}水を入れます"
  end


  def shake
    puts "#{@name}10回シェイクします"
  end
end

class SoyProtein
  def initialize
    @name = 'ソイプロテイン'
  end

  def add_milk
    puts "#{@name}牛乳を入れます"
  end

  def shake
    puts "#{@name}20回シェイクします"
  end
end

class ProteinPreparer
  def initialize(protein)
    @protein = protein.new
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

whey_protein_preparer = ProteinPreparer.new(WheyProtein)
whey_protein_preparer.execute
soy_protein_preparer = ProteinPreparer.new(SoyProtein)
soy_protein_preparer.execute
