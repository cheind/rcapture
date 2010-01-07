#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'rcapture/symbol'
require 'rcapture/capture_status'
require 'rcapture/captured_info'
require 'rcapture/singleton_class'
require 'rcapture/interceptable'
require 'rcapture/capture'
if RUBY_VERSION >= "1.9" # will fail when ruby reaches 1.10
  require 'rcapture/capture_19x'
else
  require 'rcapture/capture_18x'
end



