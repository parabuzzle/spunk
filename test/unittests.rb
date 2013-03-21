require 'test/unit'
require_relative "../lib/spunk"

Dir.glob('./test/unit_*.rb').each do|tests|
 puts tests
 require tests
end
