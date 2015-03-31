# Introduction #
RCapture is a Ruby library that allows placing hooks on methods using a convenient interface. RCapture is a versatile tool supporting different programming paradigms such as aspect-oriented programming. It is also referred to as the ['ultimate monkey patch'](http://ruby5.envylabs.com/episodes/43-episode-41-january-12-2010#story-2) library.

RCapture offers the following core features

  * Capturing of instance and class methods of individual objects or entire population of objects.
  * Capturing pre or post method invocation.
  * Multiple capturings per method.
  * Modify method arguments and return values.
  * Filter method calls.
  * Developed with multithreaded environments in mind

Here is what Gregg and Nate of [Ruby5](http://ruby5.envylabs.com/episodes/43-episode-41-january-12-2010#story-2) have to say on RCapture:
> (...) it does provide a very powerful programming tool. You can basically have hooks which manipulate the data coming into a method or going out from, at will. It’s like the ultimate monkey patch.


## Example ##
```
require 'rcapture'

class Array
  # RCapture::Interceptable is a module mixin that provides capturing capatibilities.
  include RCapture::Interceptable
end

Array.capture_post :methods => [:<<, :push] do |cs|
  puts "#{cs.args.first} was inserted to array #{cs.sender}"
end

[] << 1 << 2
[].push 3

#=> 1 was inserted to array [1]
#=> 2 was inserted to array [1, 2]
#=> 3 was inserted to array [3]
```

More examples can be found [here](http://rcapture.googlecode.com/svn/trunk/doc/index.html) or [here](http://cheind.wordpress.com/2010/01/07/introducing-rcapture/#more-252).

## Installation ##
You can install RCapture using [RubyGems](http://docs.rubygems.org/) by invoking
```
> gem install rcapture
Successfully installed rcapture-1.0.4
```
in case that fails, you might want to update your gem system before installing RCapture
```
> gem update --system
```

Alternatively download the gem from the [download](http://code.google.com/p/rcapture/downloads/list) section and install locally
```
> gem install rcapture-1.0.4.gem
```

## Documentation ##
An up-to-date RCapture documentation can be found [here](http://rcapture.googlecode.com/svn/trunk/doc/index.html).

Christoph has written an [introductionary article](http://cheind.wordpress.com/2010/01/07/introducing-rcapture/#more-252) to RCapture at his [blog](http://cheind.wordpress.com).

Make sure you read the HowTo page.

## Help Wanted! ##
Due to the limited amount of time I can spend on this project, I'm actively searching for people joining the project. If you'd like to contribute, get in [touch](http://cheind.wordpress.com/contact/) now!
