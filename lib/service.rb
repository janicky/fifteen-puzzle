require "fifteen_puzzle_solver"
require "colorize"
require_relative "report"

class Service
  def initialize(params)
    # Assign params
    vars = %w[algorithm acronym input_file solution_file stats_file]
    vars.each_with_index do |value, index|
      instance_variable_set("@#{value}".to_sym, params[index])
    end

    # Set files valid directories
    @filename = @input_file
    @input_file = "../data/#{@input_file}"
    @solution_file = "../data/#{@solution_file}"
    @stats_file = "../data/#{@stats_file}"

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

    File.open("../data/logs.txt", "a") do |f|
      f.write("===============\nStarted #{@filename} - #{@algorithm} / #{@acronym} at #{time}\n")
    end

    fps = FifteenPuzzleSolver.new(solver_params)
    fps.perform

    # Save solution report
    solution_report = Report.new("solution", @solution_file, fps.result)
    solution_report.save

    # Save stats report
    stats_report = Report.new("stats", @stats_file, fps.result)
    stats_report.save

    finished = "Finished #{@filename} - #{@algorithm} / #{@acronym} "\
      "in #{to_ms(fps.result.elapsed_time)} ms"

    puts finished.green
    File.open("../data/logs.txt", "a") do |f|
      f.write("#{finished}\n")
    end
  end

  def time
    Time.now.strftime("%d-%m-%Y %H:%M:%S")
  end

  def to_ms(time)
    (time * 1000).round(3)
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
