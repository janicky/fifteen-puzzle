require "fifteen_puzzle_solver"
require "colorize"
require_relative "service"

class FifteenPuzzle
  def initialize(params)
    if params.count == 5
      begin
        Service.new(params)
      rescue Exception => exception
        puts exception.message.red
      end
    else
      usage
    end
  end

  private

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
