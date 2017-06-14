require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    if index >= @length
      raise "index out of bounds"
    else
      @store[index]
    end
  end

  # O(1)
  def []=(index, value)
    if index >= @length
      raise "index out of bounds"
    else
      @store[index] = value
    end
  end

  # O(1)
  def pop
    if @length <= 0
      raise "index out of bounds"
    else
      @length -= 1
      @store[@length]
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      resize!
    end
    @length += 1
    @store[@length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length <= 0
      raise "index out of bounds"
    else
      new_array = StaticArray.new(@capacity)
      first = @store[0]
      (0...@length - 1).each do |index|
        new_array[index] = @store[index + 1]
      end
      @store = new_array
      @length -= 1
      first
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length + 1 == @capacity
      resize!
    end
    new_array = StaticArray.new(@capacity)
    new_array[0] = val
    (0..@length - 1).each do |index|
      new_array[index + 1] = @store[index]
    end
    @length += 1
    @store = new_array
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity * 2
    new_store = StaticArray.new(@capacity)
    (0...@length).each do |index|
      new_store[index] = @store[index]
    end
    @store = new_store
  end
end
