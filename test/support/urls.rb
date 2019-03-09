# frozen_string_literal: true

VALID_URLS = [
  "http://example.com",
  "http://example.com/",
  "http://www.example.com/",
  "http://sub.domain.example.com/",
  "http://bbc.co.uk",
  "http://example.com?foo",
  "http://example.com?url=http://example.com",
  "http://example.com:8000",
  "http://www.sub.example.com/page.html?foo=bar&baz=%23#anchor",
  "http://user:pass@example.com",
  "http://user:@example.com",
  "http://example.com/~user",
  "http://example.museum",
  "http://1.0.255.249",
  "http://1.2.3.4:80",
  "HttP://example.com",
  "https://example.com",
  # "http://räksmörgås.nu", # IDN
  "http://xn--rksmrgs-5wao1o.nu", # Punycode
  "http://www.xn--rksmrgs-5wao1o.nu",
  "http://foo.bar.xn--rksmrgs-5wao1o.nu",
  "http://example.xy", # Only valid TLD
  "http://example.com.", # Explicit TLD root period
  "http://example.com./foo"
].freeze

INVALID_URLS = [
  "url",
  "www.example.com",
  "http://ex ample.com",
  "http://example.com/foo bar",
  "http://256.0.0.1",
  "http://u:u:u@example.com",
  "http://r?ksmorgas.com",

  # These can all be valid local URLs, but should not be considered valid
  # for public consumption.
  "http://example",
  "http://example.c",
  "http://example.toolongtld"
].freeze
