# frozen_string_literal: true

module Validators
  class DisposableHostnames
    FILE_PATH = File.expand_path("../../data/disposable.json", __dir__)

    def self.all
      @all ||= JSON.parse(File.read(FILE_PATH))
    end
  end
end
