$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'benchmark'
require 'speed_racer/extensions'
require 'speed_racer/comparison'
require 'speed_racer/comparison/measurement'

module SpeedRacer
  def self.go(n=1, &block)
    comparison = SpeedRacer::Comparison.new(n)
    comparison.instance_eval(&block)
    comparison.ensure_equivalent_results
    puts comparison.to_s
  end
end