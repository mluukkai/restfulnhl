class Formatter
  def self.goal
    GoalFormatter.new
  end

  def self.assist
    AssistFormatter.new
  end

  def self.point
    PointFormatter.new
  end

  def points point
    point
  end

  def assists assist
    assist
  end

  def goals goal
    goal
  end
end

class GoalFormatter < Formatter
  def goals goal
    "<b>#{goal}</b>"
  end
end

class AssistFormatter < Formatter
  def assists assist
    "<b>#{assist}</b>"
  end
end

class PointFormatter < Formatter
  def points point
    "<b>#{point}</b>"
  end
end
