# YARD plugin that creates documentation for minitests. Inspired from yard-minitest-spec gem.
YARD::Templates::Engine.register_template_path '/doc/templates'
# This class handles test statements and the assert orders
class YardMiniTestSpecDescribeHandler < YARD::Handlers::Ruby::Base
  handles method_call(:test)                                         # identify the test method
  def process
    name = statement.parameters.first.jump(:string_content).source
    obj = MethodObject.new(namespace, name, scope)
    register(obj)                                                    # register the object to get the source code
    statement.last.traverse do |node|
      if  node.type == :ident and node.first[0..5].to_s == "assert"  #identify the assert lines
        (obj[:specifications] ||= []) << {
          assert: node.show                                          #return the line
        }
      end
    end    
    nil
  rescue YARD::Handlers::Ruby::NamespaceMissingError
  end
end
