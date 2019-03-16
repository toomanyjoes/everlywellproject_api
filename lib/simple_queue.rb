class SimpleQueue
  def initialize
    @structure = Array.new
  end

  def dequeue
    @structure.shift
  end

  def enqueue(element)
    @structure.unshift(element)
    self
  end

  def append(element)
    @structure.push(element)
    self
  end

  def size
    @structure.size
  end

  def to_s
    p @structure
  end
end