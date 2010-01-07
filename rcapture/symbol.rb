
# Extend Symbol to override default to_a behaviour which is deprecated.
class Symbol
  def to_a
    return [self]
  end
end