module Test
  
  def self.test()
    puts 'test'
  end
  
  class Test 
    def self.classtest()
      puts "Test::Test.test"
    end
    def methodtest()
      puts "Test::Test-instance.test"
    end
  end
end

Test::Test.classtest
t = Test::Test.new
t.methodtest
Test.test
