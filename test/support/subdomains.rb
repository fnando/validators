VALID_SUBDOMAINS = %W[
  #{'a'*63}
  mysite
  my-site
  mysite-
  mysite1234
  1234mysite
  MYSITE
  MYSITE1234
  1234MYSITE
  mysite--
]

INVALID_SUBDOMAINS = %W[
  -mysite
  1234
  #{'a'*64}
]
