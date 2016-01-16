class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    return false if @store[num]
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false  if include?(num) == true
    false
  end

  def include?(num)
    validate!(num)
    return @store[num]
  end

  private

  def is_valid?(num)
    return false if num > @store.length - 1 || num < 0
    true
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    mod = num % 20
    @store[mod] << num unless include?(num)
  end

  def remove(num)
    mod = num % 20
    @store[mod].delete(num) if include?(num)
  end

  def include?(num)
    mod = num % 20
    @store[mod].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    mod = num % 20
    @store[mod]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1 unless include?(num)
    if @count > @store.length
      resize!
    end
    mod = num % @store.length
    @store[mod] << num
  end

  def remove(num)
    mod = num % @store.length
    @store[mod].delete(num)
  end

  def include?(num)
    mod = num % @store.length
    @store[mod].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(@store.length * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        mod = el % new_array.length
        new_array[mod] << el
      end
    end

    @store = new_array
  end
end
