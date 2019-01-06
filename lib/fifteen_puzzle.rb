require "colorize"

class FifteenPuzzle
  def initialize(params)
    init(params)

    # Assign params
    vars = %w[algorithm acronym input_file results_file stats_file]
    vars.each_with_index do |value, index|
      instance_variable_set("@#{value}".to_sym, params[index])
    end
    validate
  end

  private

  def init(params)
    # Validate params count and display usage
    return usage unless params.count == 4
  end

  def validate; end

  def usage
    puts "Usage: fifteen-puzzle [algorithm] [heuristic/order] "\
      "[initial file] [results file] [stats file]".yellow
    puts "Algorithms: #{'bfs'.green} (breadth first), #{'dfs'.green} "\
      "(depth first), #{'astr'.green} (a star)"
    puts "Heuristics (only astr): #{'manh'.green} (manhattan), #{'hamm'.green} "\
      "(hamming)"
    puts "Order (only bfs/dfs): #{'[udlr]'.green} permutations, e.g. rlud, dlru"
  end

end
