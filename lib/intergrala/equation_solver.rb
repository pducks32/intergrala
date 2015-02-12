module EquationSolver

  @@normalize_mappings = {"dependentVariable" => "dependent",
                          "independentVariable" => "independent",
                          "integrationMethod" => "method",
                          "upperBound" => "upper_bound",
                          "lowerBound" => "lower_bound" }

  def self.call(data)
    result = EquationRunner.call(data)
    report result
    return {message: "failure"} if result.failed?
    return new_equation result.as_json.merge(data)
  end

  private

  def self.new_equation(data)
    normalize_json! data
    Equation.new **data
  end

  def self.normalize_json!(data)
    data.keys.each { |k| data[ @@normalize_mappings[k] ] = data.delete(k) if @@normalize_mappings[k] }
    data[:bounds] = data.delete(:lower_bound)..data.delete(:upper_bound)
    symbolize_keys! data
  end

  def self.symbolize_keys!(hash)
    hash.keys.each do |key|
      symbol    = key.to_sym
      hash[symbol] = hash.delete key
    end
  end

  def report(result)
    if result.errors?
      $logger.scream(:python, "Returned Errors", data: result.errors)
    elsif result.shell_method?
      $logger.scream(:solver, "Used Shell Method")
    else
      $logger.scream(:solver, "Unknown")
    end
  end

end
