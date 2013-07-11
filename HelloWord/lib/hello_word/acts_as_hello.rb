module HelloWord
    module ActsAsHello
        def self.included(base)
            
            base.send :include, HelloWord::InstanceMethods
            base.extend HelloWord::ClassMethods
        end
    end

    module ClassMethods      
        def hellolize
            include HelloWord::InstanceMethods
        end
    end

    module InstanceMethods
        def hee
            puts "==pp"
        end
    end
end
