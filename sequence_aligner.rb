# Sequence alignment is a well-trodden path, and this is by no means a general
# solution (we'd call into well-known libraries if it were intended as such).
# But, for a few simple cases, we don't need to take things too far to get a
# useful tool.
class SequenceAligner
  attr_accessor :matrix

  def initialize(a, b)
    dimx, dimy = a.length + 1, b.length + 1
    @a, @b = a, b
    @matrix = Automatrix.from_proc(dimx, dimy, &method(:matrix_value))
  end

  def matches?(row, col)
    (row == col && col == 0) || @a[row] == @b[col]
  end
end
