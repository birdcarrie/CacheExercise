require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    @count += 1 unless include?(key)
    resize! if @count > @store.length
    mod = key.hash % @store.length
    @store[mod] << key
  end

  def include?(key)
    mod = key.hash % @store.length
    @store[mod].include?(key)
  end

  def remove(key)
    return false unless  include?(key)
    mod = key.hash % @store.length
    @store[mod].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(@store.length * 2) {Array.new}
    @store.each do |bucket|
      bucket.each do |el|
        mod = el.hash % new_array.length
        new_array[mod] << el
      end
    end
    @store = new_array
  end
end
