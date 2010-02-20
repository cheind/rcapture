
# = Introduction
# The module RCapture is your single entry point when it comes to
# method capturing/hooking.
#
# To hook/capture methods you need to
# - enrich target(s) with capturing capatibilities. This is provided by the module mixin Interceptable.
# - capture the methods by invoking methods from Interceptable.
#
# = Examples
# Here is a set of examples that should help you getting started. Those examples are part of
# the RCapture distribution
#
# == Hello World
# The following example illustrates basic class and instance level hooking and
# makes use of the passed CapturedInfo instance to query details.
# :include:example/hello_world.rb
#
# == Class Methods
# In this example quickly shows how to hook class methods.
# :include:example/class_methods.rb
#
# == Modifying Arguments and Return Values
# The following example illustrates capturing methods in order to modify input and return arguments.
# Further, it illustrates how capture methods of a single instance only.
# :include:example/modify_arguments.rb
#
# == Filtering Method Calls
# Additionally to modifying arguments you can prevent captured method from being called using a Interceptable#capture_pre hook.
# :include:example/filter_method_calls.rb
#
# == Callbacks Are Capture-Free
# During processing of a callback, capturing is disabled. Otherwise, this could lead to infinite recursion as the following
# examples demonstrates.
# :include:example/no_endless_recursion.rb
#
# == Inheritance
# Captured methods propagate through derivates as long as they are not overridden by a class.
# :include:example/inheritance.rb
#
# == Multithreading
# RCapture is a lock-free implementation that supports multithreading. There is no restriction on the number of threads
# that call a shared callback. Captures, however, should be called only from a single thread or guaranteed to be synchronized
# by the user. Since callbacks can be invoked from multiple threads in parallel, shared resources from within the callbacks
# need to be synchronized by the user. The passed CapturedInfo is a thread-local variable and needs not to be synchronized.
# The following example illustrates this.
# :include:example/multithreaded.rb
#
# == New with Block
# Here is one final example that stimulate your imagination of what can be done with RCapture: given any class, it is often
# desireable to work with newly created instance by passing a block to new. If that class does not support this you can use
# RCapture to enable this behaviour.
# :include:example/new_with_block.rb
#
# = Benchmark
# RCapture works on Ruby 1.8.x and 1.9.x. Due to API changes between 1.8 and 1.9, RCapture selects an appropriate
# implementation of its core methods. Here is a benchmark that illustrates the overhead on 1.8 and 1.9 when
# a captured method is called.
# :include:test/benchmark/benchmark_capture.rb
module RCapture
end