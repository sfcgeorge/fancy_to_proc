require "fancy_to_proc/version"
require "rubocop/cop/fancy_to_proc/space_around_most_operators"

module FancyToProc
end

class Symbol
  def ~
    method(self).to_proc
  end unless method_defined?(:~)

  def |(other)
    proc { |*args| args.shift.__send__(self, other) }
  end unless method_defined?(:|)

  def &(other)
    proc { |*args| other.to_proc.call to_proc.call(*args) }
  end unless method_defined?(:&)

  def call(*defaults)
    proc { |*args| args.shift.__send__(self, *defaults) }
  end unless method_defined?(:call)
end

class Proc
  def |(other)
    curry(2)[other]
  end unless method_defined?(:|)

  def &(other)
    proc { |*args| other.to_proc.call call(*args) }
  end unless method_defined?(:&)
end

class Array
  def to_proc
    proc { |args| args[*self] }
  end unless method_defined?(:to_proc)
end
