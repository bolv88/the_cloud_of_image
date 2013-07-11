require "hello_word/hello_word.rb"
require "hello_word/acts_as_hello"
module HelloWord
end
ActiveRecord::Base.send(:include, HelloWord::ActsAsHello)  
