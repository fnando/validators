# frozen_string_literal: true

module Validators
  class DisposableHostnames
    FILE_PATH = File.expand_path("../../data/disposable_domains.txt", __dir__)

    def self.all
      @all ||= File.read(FILE_PATH).lines.map(&:chomp)
    end
  end
end
