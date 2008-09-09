module SpeedRacer
  class Comparison
    class Measurement
      attr_reader :name, :measured_time, :result, :data, :times

      def initialize(name, times, *data, &block)
        @name   = name
        @data   = data
        @times  = times
        @measured_time = block_given? ? average(:real, &block) : 0.0
      end

      def differential(other)
        if measured_time == other.measured_time
          1.0
        elsif measured_time < other.measured_time
          other.measured_time / measured_time
        else
          (measured_time / other.measured_time) * -1
        end
      end
      
      def measure
        args = data.map {|o| o.dup}
        
        t0, r0 = Benchmark.times, Time.now
        @result = yield(*args)
        t1, r1 = Benchmark.times, Time.now
        
        Benchmark::Tms.new(t1.utime  - t0.utime, 
                           t1.stime  - t0.stime, 
                           t1.cutime - t0.cutime, 
                           t1.cstime - t0.cstime, 
                           r1.to_f   - r0.to_f, '')
      end

      def average(metric=:real, &block)
        (1..times).map { measure(&block).send(metric) }.average
      end
      
      def to_s(baseline=self)
        "%-40s %.6f (%.1f)" % [ name, measured_time, differential(baseline) ]
      end
    end
  end
end