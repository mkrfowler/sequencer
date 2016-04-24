class NeedlemanWunsch < SequenceAligner
  MATCH = 1
  MISMATCH = -1
  INDEL = -1

  def matrix_value(row, col)
    return -(row + col) if (row == 0 || col == 0)

    hscore = matrix[row - 1, col    ] + INDEL
    vscore = matrix[row    , col - 1] + INDEL
    dscore = matrix[row - 1, col - 1] + (matches?(row, col) ? MATCH : MISMATCH)

    return [hscore, vscore, dscore].max
  end
end
