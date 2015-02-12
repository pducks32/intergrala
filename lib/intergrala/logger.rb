require "colorize"
module Intergrala
  class Logger

    @@color_mappings = {router: :green, solver: :cyan, python: :magenta}

    def initialize(debug: false)
      @debug = debug
    end

    def log(process, action, data: nil)
      write [format_process(process), format_action(process, action, data)].join(" ")
    end

    def scream(process, action, data: nil)
      write [format_process(process, scream: true), format_action(process, action, data, scream: true)].join(" ")
    end

    def debug?
      !!@debug
    end

    private

    def write(text)
      puts text
    end

    def format_process(process, scream: false)
      text = process.to_s.capitalize!.concat(": ")
      color(:process, text, color: @@color_mappings[process], scream: scream).on_black.bold
    end

    def format_action(process, action, data, scream: false)
      action = action.split(" ").map(&:capitalize).join(" ")
      return color(:action, action, color: @@color_mappings[process], scream: scream) unless debug?
      action << " " << color(:arguments, data, color: @@color_mappings[process], scream: scream) << " " if debug? and !data.nil?
    end

    def color(type, text, color: :black, scream: false)
      color = color.to_s.prepend("light_").to_sym if type == :arguments
      return text = text.colorize(color) unless scream
      text.blink.underline.bold
    end
  end
end
