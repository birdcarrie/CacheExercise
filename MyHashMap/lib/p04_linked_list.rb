class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.nil?
  end

  def get(key)
    # currentlink = @head
    # until currentlink == nil
    #   return currentlink.val if key == currentlink.key
    #   currentlink = currentlink.next
    # end
    # nil
    self.each do |link|
      if link.key == key
        return link.val
      end
    end
    nil
  end

  def include?(key)
    self.each do  |link|
      return true if link.key == key
    end
    false
  end

  def insert(key, val)
    if @head == nil
      @head = Link.new(key, val)
      @tail = @head
    else
      link = Link.new(key, val)
      link.next = nil
      link.prev = @tail
      @tail.next = link
      @tail = link
    end
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        if link.next == nil && link.prev == nil
          @head = nil
          @tail = nil
        elsif link.next == nil
          link.prev.next = nil
          @tail = link.prev
        elsif link.prev == nil
          link.next.prev = nil
          @head = link.next
        else
          link.next.prev = link.prev
          link.prev.next = link.next
        end
      end
      # if link.key == key
      #   link.next.prev = link.prev
      #   link.prev.next = link.next
      #   link.next = nil
      #   link.prev = nil
      # end
    end
  end

  def each(&blk)
    currentlink = @head
    until currentlink == nil
      blk.call(currentlink)
      currentlink = currentlink.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
