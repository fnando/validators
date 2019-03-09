# frozen_string_literal: true

VALID_DATES = [
  "2010-04-26",
  "2010-04-26 23:59:00",
  "26/04/2010",
  "2000-08-01 00:00:00 +0900",
  "Aug 21 2000",
  "Thu Nov 29 14:33:20 GMT 2001",
  Time.now,
  Date.today,
  DateTime.now,
  Time.zone.now
].freeze

INVALID_DATES = [
  "invalid",
  nil,
  "",
  "4/26"
].freeze
