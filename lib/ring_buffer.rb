require_relative "static_array"
require "byebug"

class RingBuffer
  attr_reader :length

  def initialize
    @start_idx = 0;
    @length = 0;
    @capacity = 8;
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    if index >= @length
      raise "index out of bounds"
    else
      @store[(start_idx + index) % capacity]
    end
  end

  # O(1)
  def []=(index, val)
    if index >= @length
      raise "index out of bounds"
    else
      @store[(start_idx + index) % capacity] = val
    end
  end

  # O(1)
  def pop
    if @length <= 0
      raise "index out of bounds"
    else
      last = @store[(start_idx + length - 1) % capacity]
      @length -= 1
      @store[(start_idx + length) % capacity] = nil
      last
    end
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      resize!
    end
    @length += 1
    @store[(start_idx + length - 1) % capacity] = val
  end

  # O(1)
  def shift
    if @length <= 0
      raise "index out of bounds"
    else
      first = @store[start_idx % capacity]
      @store[start_idx % capacity] = nil
      @start_idx += 1
      @length -= 1
      first
    end
  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      resize!
    end
    @start_idx -= 1
    @store[start_idx % capacity] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    (0...@length).each do |index|
      new_store[index] = self[index]
    end
    @capacity *= 2
    @start_idx = 0
    @store = new_store
  end
end
