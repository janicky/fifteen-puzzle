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

    puts @blocks.inspect
  end

  private

  def read_input
    input = File.open(@input_file).to_a
    @width, @height = input.first.strip.split(" ")
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
