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

  def to_s
    if @size == 0
      "| |"
    elsif @size > 0
      list = []
      @size.times do |i|
        list.push(self.get(i))
      end
      "| "+list.join(', ')+" |"
    end
  end

  def delete(index)
    @size -= 1
    if index == 0
      @first_item = get_list_item(1)
    else
      deleted = get_list_item(index)
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


  private # anything below this is private.

  def last_item
    current_item = @first_item
    until current_item.last?
      current_item = current_item.next_item
    end
    current_item
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

end
