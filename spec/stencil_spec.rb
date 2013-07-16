require 'spec_helper'

describe Stencil do
  it "should work" do
    fixture = "#{$root}/spec/fixture"
    FileUtils.rm_rf(fixture)
    FileUtils.mkdir_p("#{fixture}/project")
    File.open("#{fixture}/project/project.rb", 'w') do |f|
      f.write("project\nProject")
    end
    Dir.chdir(fixture)
    `git init .`
    `git remote add origin https://github.com/winton/project.git`
    Stencil.new("project->new_project", "Project->NewProject")
  end
end