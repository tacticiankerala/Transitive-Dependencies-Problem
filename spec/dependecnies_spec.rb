require './src/dependencies'

describe Dependencies do
  it "should return the proper dependencies" do
    dep = Dependencies.new
    dep.add_direct('A', %w{ B C })
    dep.add_direct('B', %w{ C E })
    dep.add_direct('C', %w{ G   })
    dep.add_direct('D', %w{ A F })
    dep.add_direct('E', %w{ F   })
    dep.add_direct('F', %w{ H   })
    
    dep.dependencies_for('A').should eql %w{ B C E F G H }
    dep.dependencies_for('B').should eql %w{ C E F G H }
    dep.dependencies_for('C').should eql %w{ G }
    dep.dependencies_for('D').should eql %w{ A B C E F G H } 
    dep.dependencies_for('E').should eql %w{ F H } 
    dep.dependencies_for('F').should eql %w{ H }
  end
  
  it "should handle circular dependency" do
    dep = Dependencies.new
    dep.add_direct('A', %w{ B })
    dep.add_direct('B', %w{ C })
    dep.add_direct('C', %w{ A })
    
    dep.dependencies_for('A').should eql %w{ A B C }
    dep.dependencies_for('B').should eql %w{ A B C }
    dep.dependencies_for('C').should eql %w{ A B C }
  end
end
