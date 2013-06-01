module ValveParser

  class Parser
    def initialize
      @root = {}
      @stack = [@root]
    end

    def feed line
      case line
      when /^\/{2}.*$/                  # a comment, ignore
      when /^"([^"]*)"$/                # name of a new hash, handle
        hash = {}
        @stack.last[$1] = hash
        @stack.push hash
      when /^[{]$/                      # start of a new hash, nothing to do
      when /^[}]$/                      # end of current hash
        @stack.pop
      when /^"([^"]*)"\s*"([^"]*)".*$/  # key value pair
        @stack.last[$1] = $2
      when /^$/                         # empty line, ignore
      else
        puts "->#{line}<-"
        raise 'wtf'
      end
    end

    def result
      @root
    end
  end

  def self.parse file
    parser = Parser.new
    File.open(file, 'r').readlines.each { |line| parser.feed line.strip }
    parser.result
  end

end