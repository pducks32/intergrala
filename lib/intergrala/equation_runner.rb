class EquationRunner < ProgramRunner

  def initialize(program: "python", file_name: "python/integrala.py", file: Pathname.new(file_name))
    super [program, file]
  end

  def shell_method?
    exitstatus == 15
  end

  def as_json
    JSON.parse @output
  end

  def failed?
    super() || shell_method?
  end
end
