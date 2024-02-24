# frozen_string_literal: true

module Instruction
  module Mode
    BOUNCE = 0
    GHOST = 1
    ZAP = 2
    FLOW = 3

    def self.all
      [BOUNCE, GHOST, ZAP, FLOW]
    end

    def self.each(&block)
      all.each(&block)
    end

    def self.count
      all.size
    end
  end
end
