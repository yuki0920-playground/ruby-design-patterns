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

estate = { name: 'サンプル不動産ビルディング', rent: 30 }
equipment = { name: 'ベンチプレスマシーン', grade: 'middle'}
gym = Gym.new(estate, equipment)
puts gym.calculate_maintenance_cost
