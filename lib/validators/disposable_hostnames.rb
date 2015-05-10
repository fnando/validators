module Validators
  class DisposableHostnames
    FILE_PATH = File.expand_path("../../../data/disposable.json", __FILE__)

    def self.all
      @tld ||= JSON.load(File.read(FILE_PATH))
    end
  end
end
