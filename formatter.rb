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

  def self.pim
    PimFormatter.new
  end

  def self.plusminus
    PlusMinusFormatter.new
  end

  def self.shots
    ShotsFormatter.new
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

  def pim pim
    pim
  end

  def plusminus pm
    pm
  end

  def shots shots
    shots
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

class PimFormatter < Formatter
  def pim pim
    "<b>#{pim}</b>"
  end
end

class PlusMinusFormatter < Formatter
  def plusminus pm
    "<b>#{pm}</b>"
  end
end

class ShotsFormatter < Formatter
  def shots shots
    "<b>#{shots}</b>"
  end
end
