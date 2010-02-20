#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'rubygems'
require 'rake'

spec = Gem::Specification.new do |s|
  s.name = 'rcapture'
  s.version = '1.0.4'
  s.summary = 'Capture and modify method invocations.'
  s.author = 'Christoph Heindl'
  s.email = 'christoph.heindl@gmail.com'
  s.homepage = 'http://cheind.wordpress.com/2010/01/07/introducing-rcapture/#more-252'
  s.description = 'RCapture allows placing hooks on methods using a convenient interface. RCapture allows pre and post invocation capturing as well as modifying input and return arguments. RCapture can thus be used as a building block in aspect oriented programming.'
  s.require_path = '.'
  s.files = FileList['rcapture.rb', 'License', 'README', 'Rakefile', 'rcapture/**/*.rb', 'test/**/*', 'example/**/*'].to_a
  s.test_files = FileList['test/unit/*'].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'License']
  s.rdoc_options << '--title' << 'RCapture -- Capturing Method Calls' << 
                           '--main' << 'README' <<
                           '-x' << 'test/*' << '-x' << 'example/*'
end


