INVALID_EMAILS = [
  'invalid@example-com',
  # period can not start local part
  '.invalid@example.com',
  # period can not end local part
  'invalid.@example.com',
  # period can not appear twice consecutively in local part
  'invali..d@example.com',
  # should not allow underscores in domain names
  'invalid@ex_mple.com',
  'invalid@example.com.',
  'invalid@example.com_',
  'invalid@example.com-',
  'invalid-example.com',
  'invalid@example.b#r.com',
  'invalid@example.c',
  'invali d@example.com',
  'invalidexample.com',
  'invalid@example.',
  # from http://tools.ietf.org/html/rfc3696, page 5
  # corrected in http://www.rfc-editor.org/errata_search.php?rfc=3696
  'Fred\ Bloggs_@example.com',
  'Abc\@def+@example.com',
  'Joe.\\Blow@example.com'
]

VALID_EMAILS = [
  'valid@somedomain.com',
  'Valid@test.somedomain.com',
  'valid+valid123@test.somedomain.com',
  'valid_valid123@test.somedomain.com',
  'valid-valid+123@test.somedomain.co.uk',
  'valid-valid+1.23@test.somedomain.com.au',
  'valid@somedomain.co.uk',
  'v@somedomain.com',
  'valid@somedomain.ca',
  'valid123.456@somedomain.org',
  'valid@somedomain.mobi',
  'valid@somedomain.info',
]
