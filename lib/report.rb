class Report
  def initialize(type, filename, data)
    @type = type
    @filename = filename
    @data = data
  end

  def save
    case @type
    when "solution"
      save_solution
    when "stats"
      save_stats
    end
  end

  private

  def save_solution
    file = File.new(@filename, "w")
    file.puts @data.status == "solved" ? @data.solution.length : -1
    file.puts @data.solution if @data.status == "solved"
    file.close
  end

  def save_stats
    file = File.new(@filename, "w")
    file.puts @data.status == "solved" ? @data.solution.length : -1
    file.puts @data.visited_nodes
    file.puts @data.processed_nodes
    file.puts @data.depth
    file.puts (@data.elapsed_time * 1000).round(3)
    file.close
  end
end
