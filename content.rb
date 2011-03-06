require 'statistics'
require 'formatter'
require "lib/update_time"

class Content
  def self.fetch_contents file = nil
    if file==nil
      Statistics.new.fetch(NHLParser.new)
    else
      Statistics.new.fetch(NHLParser.new file) 
    end
  end

  def self.update_time
    UpdateTime.get_update_time
  end

  def self.get_page page
    if page=="points"
      return PointsPage.new
    elsif page=="goals"
      return GoalsPage.new
    elsif page=="assists"
      return AssistsPage.new
    elsif page=="pim"
      return PimPage.new
    elsif page=="plusminus"
      return PlusMinusPage.new
    elsif page=="shots"
      return ShotsPage.new
    else
      return PointsPage.new
    end
  end

end

class PointsPage
    attr_reader :list, :msg, :formatter

    def initialize
      @list = Statistics.new.point_order
      @msg = "NHL statistics - ordered by total points"
      @formatter = Formatter.point
    end
end

class GoalsPage
    attr_reader :list, :msg, :formatter

    def initialize
      @list = Statistics.new.goal_order
      @msg = "NHL statistics - ordered by goals"
      @formatter = Formatter.goal
    end
end

class AssistsPage
    attr_reader :list, :msg, :formatter

    def initialize
      @list = Statistics.new.assist_order
      @msg = "NHL statistics - ordered by assists"
      @formatter = Formatter.assist
    end
end

class PimPage
    attr_reader :list, :msg, :formatter

    def initialize
      @list = Statistics.new.pim_order
      @msg = "NHL statistics - ordered by penalty minutes"
      @formatter = Formatter.pim
    end
end

class PlusMinusPage
    attr_reader :list, :msg, :formatter

    def initialize
      @list = Statistics.new.plusminus_order
      @msg = "NHL statistics - ordered by plus minus"
      @formatter = Formatter.plusminus
    end
end

class ShotsPage
    attr_reader :list, :msg, :formatter

    def initialize
      @list = Statistics.new.shots_order
      @msg = "NHL statistics - ordered by shoots on goal"
      @formatter = Formatter.shots
    end
end