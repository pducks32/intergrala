require "open4"

class ProgramRunner

  def self.call(data)
    new.call(data)
  end

  attr_reader :errors, :output, :status
  def initialize(program_args)
    @program_args = program_args
  end

  def call(args)
    arguments = @program_args + [args]
    @status = Open4::popen4(*arguments.map(&:to_s)) do |pid, stdin, stdout, stderr|
      $logger.log(:python, "Opened Pipe", data: arguments)
      stdin.close

      @output = stdout.read.strip
      @errors = stderr.read.strip
    end
    self
  end

  def failed?
    @status != 0
  end

  def exitstatus
    @status.exitstatus
  end

  def errors?
    !@errors.empty?
  end
end
