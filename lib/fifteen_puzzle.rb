require "colorize"

class FifteenPuzzle
  def initialize(params)
    init
    # Assign params
    params.each do |key, value|
      instance_variable_set("@#{key}".to_sym, value)
    end
    validate
  end

  private

  def init
    # Validate params count and display usage
    return usage unless params.count == 4
  end

  def usage
    puts "Usage: fifteen-puzzle [algorithm] [heuristic/order] "\
      "[initial file] [results file] [stats file]".yellow
    puts "Algorithms: #{'bfs'.green} (breadth first), #{'dfs'.green} "\
      "(depth first), #{'astr'.green} (a star)"
    puts "Heuristics (only astr): #{'manh'.green} (manhattan), #{'hamm'.green} "\
      "(hamming)"
    puts "Order (only bfs/dfs): #{'[udlr]'.green} permutations, e.g. rlud, dlru"
  end

  def validate; end
end
