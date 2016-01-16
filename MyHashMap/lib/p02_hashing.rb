class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_key = self.length * 5717
    hash_key = hash_key * self[-1] if self[-1].is_a?(Fixnum)
    hash_key = hash_key * self[0].ord if self[0].is_a?(String)
    hash_key
  end
end

class String
  def hash
    hash_key = self.length * 1741
    hash_key = hash_key * self[-1].ord ** 2 if self[0].ord.even?
    hash_key = hash_key * self[0].ord ** 2 if self[0].ord.odd?
    hash_key = hash_key * self[self.length/2].ord
    hash_key
  end
end

# class Hash
#   def hash
#   end
# end
