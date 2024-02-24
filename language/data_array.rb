# frozen_string_literal: true

module Language
  # Like a built-in Ruby array, but fills in "uninitialized" elements
  # with zero instead of nil. This array is only built to support
  # numerical values for the moment.
  class DataArray
    include Enumerable

    def initialize
      @impl = []
    end

    def [](index)
      @impl.fetch(index, 0)
    end

    def []=(index, value)
      raise TypeError, 'Value must be numeric' unless value.is_a? Numeric

      @impl[index] = value
    end

    def each(&block)
      if block
        @impl.each do |value|
          block.call(value || 0)
        end
      else
        Enumerator.new do |yielder|
          each(&yielder)
        end
      end
    end
  end
end
