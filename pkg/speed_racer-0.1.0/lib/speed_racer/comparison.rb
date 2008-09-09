module SpeedRacer
  class Comparison
    attr_reader :baseline, :measurements, :times

    def initialize(n)
      @times = n
      @measurements = []
    end

    def measure(name, &block)
      @measurements << Measurement.new(name, times, *data, &block)
    end

    def against(name, &block)
      @baseline = Measurement.new(name, times, *data, &block)
    end
    
    def data(*args)
      if args.empty?
        @data ||= []
        @data
      else
        @data = args
      end
    end

    def to_s
      a = []
        a << baseline.to_s
        a << ( '-' * a.first.length )
        a << measurements.sort_by {|m| m.differential(baseline) * -1}.map do |m|
          m.to_s(baseline)
        end
      a.join("\n")
    end
    alias :report :to_s
    
    def run
      ensure_equivalent_results!
      report
    end

    protected

    def ensure_equivalent_results
      measurements.each do |measurement|
        unless measurement.result == baseline.result
          raise EquivalenceFailure, "#{measurement.name} failed to match baseline #{baseline.name}; expected #{baseline.result.inspect}, but was #{measurement.result.inspect}" 
        end
      end
    end

    def include(*modules)
      singleton_class.send(:include, *modules)
    end

    def singleton_class
      class << self; self; end
    end
  end
  
  class EquivalenceFailure < RuntimeError
  end
end