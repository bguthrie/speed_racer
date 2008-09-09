module SpeedRacer
  module Extensions
    module Array
      def sum(start=0)
        inject(start) {|n, sum| n + sum}
      end unless defined?(sum)
      
      def average
        sum / size
      end unless defined?(average)
    end
  end
end

Array.send(:include, SpeedRacer::Extensions::Array)