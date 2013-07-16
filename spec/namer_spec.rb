require 'spec_helper'

describe Namer do
  it "should work" do
    fixture = "#{$root}/spec/fixture"
    
    FileUtils.rm_rf(fixture)
    FileUtils.mkdir_p("#{fixture}/project")
    
    File.open("#{fixture}/project/project.rb", 'w') do |f|
      f.write("project\nProject\nMyProject")
    end
    
    Dir.chdir(fixture)
    
    `git init .`
    `git remote add origin https://github.com/winton/project.git`

    namer = Namer.new([ "project:new_project", "Project:NewProject" ])
    namer.remote.should == "https://github.com/winton/new_project.git"

    File.read("#{fixture}/new_project/new_project.rb").should == "new_project\nNewProject\nMyProject"
  end
end