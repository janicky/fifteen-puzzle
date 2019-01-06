class Report
  def initialize(type, data)
    @type = type
    @data = data
  end

  private

  def save
    case @type
    when "solution"
      # ...
    when "stats"
      # ...
    end
  end
end
