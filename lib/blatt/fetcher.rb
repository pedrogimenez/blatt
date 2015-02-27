module Blatt
  class Fetcher
    def initialize(tree)
      @tree = tree
      @objects = {}
    end

    def get(name)
      return name if string_or_integer_dependency?(name)

      sym_name = name.to_sym
      @objects[sym_name] ||= build(@tree[sym_name])
    end

    private

    def build(object)
      dependencies = object[:dependencies].map { |dependency| get(dependency) }
      Object.const_get(object[:object]).new(*dependencies)
    end

    def string_or_integer_dependency?(name)
      return !(name.respond_to?(:to_sym) && @tree[name.to_sym])
    end
  end
end
