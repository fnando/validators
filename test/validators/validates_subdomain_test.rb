require "test_helper"

class ValidatesSubdomainTest < Minitest::Test
  VALID_SUBDOMAINS.each do |subdomain|
    test "accepts #{subdomain}" do
      site = Site.new(subdomain)
      assert site.valid?
    end
  end

  INVALID_SUBDOMAINS.each do |subdomain|
    test "rejects #{subdomain}" do
      site = Site.new(subdomain)
      refute site.valid?
    end
  end
end
