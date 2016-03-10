require "from/version"

class From
  def initialize(path)
    @module = module_from_path(path)
  end

  def import(*constants)
    ret = constants.map { |k| @module.const_get(k) }

    ret = ret.first if ret.length == 1

    ret
  end

  def include(*constants)
    # TODO: Use parent scope instead of Kernel.
    # https://github.com/ruby-heresy/from/issues/2 
    include_to(Kernel, *constants)
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
