class Service
  def initialize(params)
    # Assign params
    vars = %w[algorithm acronym input_file results_file stats_file]
    vars.each_with_index do |value, index|
      instance_variable_set("@#{value}".to_sym, params[index])
    end

    puts @algorithm
  end
end
