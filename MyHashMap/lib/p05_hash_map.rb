require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    mod = key.hash % @store.length
    @store[mod].include?(key)
  end

  def set(key, val)
    mod = key.hash % @store.length
    if @store[mod].include?(key)
      @store[mod].each do |link|
        link.val = val if link.key == key
      end
    else
      @count += 1
      resize! if @count > @store.length
      @store[mod].insert(key, val)
    end
  end

  def get(key)
    mod = key.hash % @store.length
    @store[mod].get(key)
  end

  def delete(key)
    mod = key.hash % @store.length
    if @store[mod].include?(key)
      @store[mod].remove(key)
      @count -= 1
    end
  end

  def each
    # @store.each do |list|
    #   link.each do |link|
    #     yield(link.key, link.val)
    #   end
    # end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(@store.length * 2) {LinkedList.new}
    @store.each do |linked_list|
      linked_list.each do |link|
        mod = link.key.hash % new_array.length
        new_array[mod].insert(link.key, link.val)
      end
    end
    @store = new_array
  end


  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
