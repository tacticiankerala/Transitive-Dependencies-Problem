
class Dependencies
  def initialize
    @dependency_store = {}
  end
  
  def add_direct token_name, dependencies
    @dependency_store[token_name.to_sym] = dependencies
  end
  
  def dependencies_for token_name
    @evaluated = []
    (find_dependencies_for token_name).sort
  end
  
  def find_dependencies_for token_name
    dependencies = @dependency_store[token_name.to_sym] || []
    @evaluated << token_name
    dependencies.each do |dependency|
      next if @evaluated.include?(dependency)
      dependencies = dependencies | find_dependencies_for(dependency)
    end
    dependencies
  end
end
