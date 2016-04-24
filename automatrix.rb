# Ruby's Matrix class is pretty limiting for general computation.
# This is understandable in many ways – we're not actually performing
# matrix-based computation, we're using a block of memory as an assignable
# data store.

class Automatrix
  class AutomatrixBoundsException < Exception; end
  attr_reader :dimx, :dimy

  def initialize(dimx, dimy, method)
    @dimx, @dimy = dimx, dimy
    @backing_array = Array.new(dimx * dimy, nil)

    define_singleton_method :backing, method
  end

  def self.from_proc(dimx, dimy)
    raise ArgumentError, 'Automatrix requires a block' unless block_given?

    new(dimx, dimy, Proc.new)
  end

  def [](x, y)
    raise AutomatrixBoundsException if (x < 0 || x >= dimx || y < 0 || y >= dimy)

    @backing_array[x + y * dimy] ||= backing(x, y)
  end

  def to_s
    rows = (0...dimx).map { |x|
      (0...dimy).map { |y|
        @backing_array[x + y * dimy]
      }.to_s
    }.join("\n")
  end
end
