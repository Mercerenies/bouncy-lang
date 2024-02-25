# frozen_string_literal: true

require_relative './mode'
require_relative '../point'

module Bouncy
  module Instruction
    module ReflectionTable
      ID_TABLE = {
        Point.north => Point.north,
        Point.northeast => Point.northeast,
        Point.east => Point.east,
        Point.southeast => Point.southeast,
        Point.south => Point.south,
        Point.southwest => Point.southwest,
        Point.west => Point.west,
        Point.northwest => Point.northwest,
      }.freeze

      BOUNCE_TABLE = {
        '/' => {
          Point.north => Point.east,
          Point.northeast => Point.northeast,
          Point.east => Point.north,
          Point.southeast => Point.northwest,
          Point.south => Point.west,
          Point.southwest => Point.southwest,
          Point.west => Point.south,
          Point.northwest => Point.southeast,
        }.freeze,
        '\\' => {
          Point.north => Point.west,
          Point.northeast => Point.southwest,
          Point.east => Point.south,
          Point.southeast => Point.southeast,
          Point.south => Point.east,
          Point.southwest => Point.northeast,
          Point.west => Point.north,
          Point.northwest => Point.northwest,
        }.freeze,
        '_' => {
          Point.north => Point.south,
          Point.northeast => Point.southeast,
          Point.east => Point.east,
          Point.southeast => Point.northeast,
          Point.south => Point.north,
          Point.southwest => Point.northwest,
          Point.west => Point.west,
          Point.northwest => Point.southwest,
        }.freeze,
        '|' => {
          Point.north => Point.north,
          Point.northeast => Point.northwest,
          Point.east => Point.west,
          Point.southeast => Point.southwest,
          Point.south => Point.south,
          Point.southwest => Point.southeast,
          Point.west => Point.east,
          Point.northwest => Point.northeast,
        }.freeze,
      }.freeze

      ZAP_TABLE = {
        '/' => {
          Point.north => Point.northeast,
          Point.northeast => Point.northeast,
          Point.east => Point.northeast,
          Point.southeast => Point.southwest,
          Point.south => Point.southwest,
          Point.southwest => Point.southwest,
          Point.west => Point.southwest,
          Point.northwest => Point.northeast,
        }.freeze,
        '\\' => {
          Point.north => Point.northwest,
          Point.northeast => Point.southeast,
          Point.east => Point.southeast,
          Point.southeast => Point.southeast,
          Point.south => Point.southeast,
          Point.southwest => Point.northwest,
          Point.west => Point.northwest,
          Point.northwest => Point.northwest,
        }.freeze,
        '_' => {
          Point.north => Point.east,
          Point.northeast => Point.east,
          Point.east => Point.east,
          Point.southeast => Point.east,
          Point.south => Point.west,
          Point.southwest => Point.west,
          Point.west => Point.west,
          Point.northwest => Point.west,
        }.freeze,
        '|' => {
          Point.north => Point.north,
          Point.northeast => Point.north,
          Point.east => Point.south,
          Point.southeast => Point.south,
          Point.south => Point.south,
          Point.southwest => Point.south,
          Point.west => Point.north,
          Point.northwest => Point.north,
        }.freeze,
      }.freeze

      FLOW_TABLE = {
        '/' => {
          Point.north => Point.northwest,
          Point.northeast => Point.southeast,
          Point.east => Point.southeast,
          Point.southeast => Point.southeast,
          Point.south => Point.southeast,
          Point.southwest => Point.northwest,
          Point.west => Point.northwest,
          Point.northwest => Point.northwest,
        }.freeze,
        '\\' => {
          Point.north => Point.northeast,
          Point.northeast => Point.northeast,
          Point.east => Point.northeast,
          Point.southeast => Point.southwest,
          Point.south => Point.southwest,
          Point.southwest => Point.southwest,
          Point.west => Point.southwest,
          Point.northwest => Point.northeast,
        }.freeze,
        '_' => {
          Point.north => Point.north,
          Point.northeast => Point.north,
          Point.east => Point.south,
          Point.southeast => Point.south,
          Point.south => Point.south,
          Point.southwest => Point.south,
          Point.west => Point.north,
          Point.northwest => Point.north,
        }.freeze,
        '|' => {
          Point.north => Point.east,
          Point.northeast => Point.east,
          Point.east => Point.east,
          Point.southeast => Point.east,
          Point.south => Point.west,
          Point.southwest => Point.west,
          Point.west => Point.west,
          Point.northwest => Point.west,
        }.freeze,
      }.freeze

      GHOST_TABLE = {
        '/' => ID_TABLE,
        '_' => ID_TABLE,
        '\\' => ID_TABLE,
        '|' => ID_TABLE,
      }.freeze

      TABLE = {
        Mode::BOUNCE => BOUNCE_TABLE,
        Mode::GHOST => GHOST_TABLE,
        Mode::ZAP => ZAP_TABLE,
        Mode::FLOW => FLOW_TABLE,
      }.freeze

      def self.evaluate(mode, char, delta)
        TABLE.dig(mode, char, delta) or raise "Lookup in reflection table failed for #{mode}, #{char}, #{delta}"
      end
    end
  end
end
