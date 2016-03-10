require "from/version"
require "wot/utilities"

class From
  def initialize(path)
    @module = module_from_path(path)
  end

  # Returns the specified constants from the module (as found by +from(path)+).
  #
  # +from('some_library').import(:A)+ returns +SomeLibrary::A+.
  def import(*constants)
    ret = constants.map { |k| @module.const_get(k) }

    ret = ret.first if ret.length == 1

    ret
  end

  # Includes the specified constants from the module (as found by +from(path)+)
  # into +Kernel+.
  #
  # +from('some_library').include(:A)+ aliases +A+ to +SomeLibrary::A+.
  def include(*constants)
    # Set receiver to the place include() was called from.
    receiver = Wot::Utilities.caller_binding.receiver

    # If the receiver doesn't respond to .const_set, use the class of receiver.
    receiver = receiver.class unless receiver.respond_to?(:const_set)

    include_to(receiver, *constants)
  end

  private
  def include_to(object, *constants)
    constants.map do |k|
      object.const_set(k, @module.const_get(k))
    end
  end

  # Given Object and "kernel", returns :Kernel
  def const_grep(object, constant)
    regexp = Regexp.compile(constant.to_s, Regexp::IGNORECASE)

    object.constants.grep(regexp).first.to_sym
  end

  # Given Foo and "bar_baz", returns a refence to Foo::BarBaz.
  def submodule_from_path_segment(mod, path_segment)
    constant_name = path_segment.gsub(/(^|_)(.)/) { $2.capitalize }

    unless mod.const_defined?(constant_name)
      constant_name = const_grep(mod, constant_name)
    end

    mod.const_get(constant_name)
  end

  # Given "foo/bar_baz", returns a refence to Foo::BarBaz.
  def module_from_path(path)
    path.split('/').reduce(Object, &method(:submodule_from_path_segment))
  end
end

module Kernel
  def from(path)
    require path

    From.new(path)
  end
end
