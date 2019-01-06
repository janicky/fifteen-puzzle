class Service
  def initialize(params)
    # Assign params
    vars = %w[algorithm acronym input_file results_file stats_file]
    vars.each_with_index do |value, index|
      instance_variable_set("@#{value}".to_sym, params[index])
    end

    validate
  end

  private

  def validate
    # Validate input file
    unless File.exists?(@input_file)
      raise Exception.new("Input file not found")
    end
  end
end
