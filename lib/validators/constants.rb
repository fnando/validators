# frozen_string_literal: true

module Validators
  EMAIL_FORMAT = /\A[a-z0-9]+([-._][a-z0-9]+)*(\+[^@]+)?@[a-z0-9]+([.-][a-z0-9]+)*\.[a-z]{2,}\z/i.freeze
  MICROSOFT_EMAIL_FORMAT = /\A[a-z0-9][a-z0-9._-]*[a-z0-9_-]+(\+[a-z0-9]+)?@(hotmail|outlook).com\z/i.freeze

  # Source: https://github.com/henrik/validates_url_format_of
  IPV4_PART = /\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]/.freeze # 0-255

  URL_FORMAT = %r[
    \A
    https?://                                                    # http:// or https://
    ([^\s:@]+:[^\s:@]*@)?                                        # optional username:pw@
    ( (([^\W_]+\.)*xn--)?[^\W_]+([-.][^\W_]+)*\.[a-z]{2,6}\.? |  # domain (including Punycode/IDN)...
        #{IPV4_PART}(\.#{IPV4_PART}){3} )                        # or IPv4
    (:\d{1,5})?                                                  # optional port
    ([/?]\S*)?                                                   # optional /whatever or ?whatever
    \z
  ]ixs.freeze

  URL_FORMAT_WITHOUT_TLD_VALIDATION = %r[
    \A
    https?://                                                    # http:// or https://
    ([^\s:@]+:[^\s:@]*@)?                                        # optional username:pw@
    ( (([^\W_]+\.)*xn--)?[^\W_]+([-.][^\W_]+)*\..{2,}\.? |       # domain (including Punycode/IDN)...
        #{IPV4_PART}(\.#{IPV4_PART}){3} )                        # or IPv4
    (:\d{1,5})?                                                  # optional port
    ([/?]\S*)?                                                   # optional /whatever or ?whatever
    \z
  ]ixs.freeze
end
