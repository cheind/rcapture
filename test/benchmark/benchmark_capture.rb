  require 'test/unit'
  require 'test/unit/testee'
  require 'benchmark'
  require 'rcapture'

  class Fixnum
    include RCapture::Interceptable
  end

  class BenchmarkCapture < Test::Unit::TestCase
    
    def test_benchmark_native
      n = 100000
      puts "Benchmarking addition"
      Benchmark.bm do |x|
        x.report { n.times do; 1+1; end }
        Fixnum.capture :methods => :+ do
        end
        x.report { n.times do; 1+1; end }
      end
      
      # On my machine Intel Q6600, 2.4GHz
      #
      # Ruby 1.8.6
      # user     system      total        real
      # 0.015000   0.000000   0.015000 (  0.027000)
      # 1.610000   0.000000   1.610000 (  1.629000)
      # overhead is roughly 0,00001602 secs per invocation
      #
      # Ruby 1.9.1
      # user     system      total        real
      # 0.000000   0.000000   0.000000 (  0.009765)
      # 0.359000   0.000000   0.359000 (  0.356446)
      # overhead is roughly 0,0000034 secs per invocation
    end
    
    def test_benchmark_construct
      n = 100000
      puts "Benchmarking construction of new objects"
      Benchmark.bm do |x|
        x.report { n.times do; Testee.new; end }
        Testee.capture :class_methods => :new do
        end
        x.report { n.times do; Testee.new; end }
      end
      
      # On my machine Intel Q6600, 2.4GHz
      #
      # user     system      total        real
      # 0.188000   0.000000   0.188000 (  0.208000)
      # 1.812000   0.000000   1.812000 (  1.836000)
      # overhead is roughly 0,00001628 secs per invocation
      #
      # Ruby 1.9.1
      # user     system      total        real
      # 0.047000   0.000000   0.047000 (  0.051757)
      # 0.422000   0.000000   0.422000 (  0.408203)
      # overhead is roughly 0,00000357 secs per invocation
    end
  end
