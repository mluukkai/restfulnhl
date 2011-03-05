class Player
  attr_reader :goals, :assists

  def initialize name, team, games, goals, assists
    @name = name
    @team = team
    @games = games
    @goals = goals
    @assists = assists
    @points = @goals + @assists
  end

  def to_s
    "#{@name.ljust(20)} #{@team}   #{@games}  #{@goals} + #{@assists} = #{@points}"
  end
end

