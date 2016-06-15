require "fancy_to_proc/version"
require "rubocop/cop/fancy_to_proc/space_around_most_operators"

module FancyToProc
end

class Symbol
  def ~
    method(self).to_proc
  end unless respond_to?(:~)

  def |(other)
    proc { |*args| args.shift.__send__(self, other) }
  end unless respond_to?(:|)

  def &(other)
    proc { |*args| other.to_proc.call to_proc.call(*args) }
  end unless respond_to?(:&)

  def call(*defaults)
    proc { |*args| args.shift.__send__(self, *defaults) }
  end unless respond_to?(:call)
end

class Proc
  def |(other)
    curry(2)[other]
  end unless respond_to?(:|)

  def &(other)
    proc { |*args| other.to_proc.call call(*args) }
  end unless respond_to?(:&)
end
