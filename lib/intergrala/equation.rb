class Equation
  def initialize(dependent:, independent:, expression:, bounds:, latex:, answer:, method:)
    @dependent, @independent, @expression, @bounds, @latex, @answer, @method = dependent, independent, expression, bounds, latex, answer, method
  end

  def to_json
    {
      "dependentVariable": @dependent,
      "independentVariable": @independent,
      "expression": @expression,
      "bounds": @bounds.minmax,
      "latex": @latex,
      "volume": @answer,
      "method": @method
    }.to_json
  end
end
