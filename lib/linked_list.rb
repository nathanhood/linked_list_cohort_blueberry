class LinkedList
  attr_accessor :size

  def initialize(*values)
    @size = 0
    @last = 0
    if values.length > 0
      values.each { |value| push(value) }
    end
  end

  def push(value)
    @size += 1

    lli = LinkedListItem.new(value)
    if @first_item
      last_item.next_item = lli
    else
      @first_item = lli
    end
  end

  def [](index)
    get(index)
  end

  def []=(index, value)
    lli = get_list_item(index)
    lli.payload = value
  end

  def last
    if @size == 0
      nil
    else
      self.get(@size - 1)
    end
  end

  def sorted?
    return true if self.size <= 1
    @size.times do |i|
      current_item = self.get_list_item(i)
      unless current_item.last?
        results = current_item <=> current_item.next_item
        if results == 1
          return false
        end
      end
    end
  end


  def sort!
    swapped = true

    while swapped do
      swapped = false

      if self.size > 1
        0.upto(@size - 2) do |i|
          current_item = self.get_list_item(i)
          second_item = current_item.next_item
          result = current_item <=> second_item

          if result == 1
            self.swap_with_next(i)
            swapped = true
          end
        end
      end
    end
  end

  def swap_with_next(i)
    raise IndexError if i >= self.size - 1
    current_item = self.get_list_item(i)
    second_item = current_item.next_item

    if second_item.last?
      current_item.next_item = nil
    else
      current_item.next_item = second_item.next_item
    end

    if i > 0
      self.get_list_item(i-1).next_item = second_item
    elsif i == 0
      @first_item = second_item
    end

    second_item.next_item = current_item
    swapped = true
  end


  def to_s
    result = "|"
    current_item = @first_item
    until current_item.nil?
      result << " #{current_item.payload}"
      unless current_item.last?
        result << ","
      end
      current_item = current_item.next_item
    end
    result << " |"
    result
  end

  def delete(index)
    @size -= 1
    if index == 0
      @first_item = get_list_item(1)
    else
      prev = get_list_item(index - 1)
      new_next = get_list_item(index + 1)
      prev.next_item = new_next
    end
  end

  def index(value)
    if @size == 0
      return nil
    end

    @size.times do |i|
      if get_list_item(i).payload.include?(value)
        return i
      elsif i == @size - 1
        return nil
      end
    end
  end

  def get(index)
    raise IndexError if index < 0

    current_item = @first_item
    index.times do
      raise IndexError if !current_item
      current_item = current_item.next_item
    end
    current_item.payload
  end

  def get_list_item(index)
    raise IndexError if index < 0

    current_item = @first_item
    index.times do
      raise IndexError if !current_item
      current_item = current_item.next_item
    end
    current_item
  end

  private # anything below this is private.

  def last_item
    current_item = @first_item
    until current_item.last?
      current_item = current_item.next_item
    end
    current_item
  end

end
