# frozen_string_literal: true

module Bouncy
  module Instruction
    module Mode
      BOUNCE = 0
      GHOST = 1
      ZAP = 2
      FLOW = 3

      def self.[](name)
        case name
        when 0 then 'BOUNCE'
        when 1 then 'GHOST'
        when 2 then 'ZAP'
        when 3 then 'FLOW'
        else raise "Invalid mode #{name}"
        end
      end

      def self.all
        [BOUNCE, GHOST, ZAP, FLOW]
      end

      def self.each(&block)
        all.each(&block)
      end

      def self.count
        all.size
      end

      def self.default
        BOUNCE
      end
    end
  end
end
