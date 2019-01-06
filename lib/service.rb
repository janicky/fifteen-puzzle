require "fifteen_puzzle_solver"
require_relative "report"

class Service
  def initialize(params)
    # Assign params
    vars = %w[algorithm acronym input_file results_file stats_file]
    vars.each_with_index do |value, index|
      instance_variable_set("@#{value}".to_sym, params[index])
    end

    validate

    # Read width, height and blocks
    # from input file
    read_input

    # Start solver
    start
  end

  private

  def start
    solver_params = {
      blocks: @blocks,
      width: @width,
      height: @height,
      algorithm: @algorithm,
      acronym: @acronym,
    }
    fps = FifteenPuzzleSolver.new(solver_params)
    fps.perform

    stats_report = Report.new("stats", @stats_file, fps.result)
    stats_report.save
  end

  def read_input
    input = File.open(@input_file).to_a
    @width, @height = input.first.strip.split(" ").map(&:to_i)
    @blocks = []
    input.each_with_index do |line, index|
      next if index == 0

      @blocks += line.strip.split(" ").map(&:to_i)
    end
  end

  def validate
    # Validate input file
    unless File.exists?(@input_file)
      raise Exception.new("Input file not found")
    end
  end
end
