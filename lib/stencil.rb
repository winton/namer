$:.unshift File.dirname(__FILE__)

class Stencil
  
  def initialize(args)
    path = Dir.pwd
    args.each do |arg|
      next unless arg.include?('->')
      @from, @to  = arg.split('->')
      rename        unless args.include?('--no-rename')
      replace       unless args.include?('--no-replace')
      rename_remote unless args.include?('--no-remote')
    end
  end

  def gsub(str)
    str.gsub(/(\W|^)#{@from}(\W|$)/, "\\1#{@to}\\2")
  end

  def self.remote
    `git remote show -n origin`.match(/Push\s+URL:\s+(\S+)/)[1] rescue nil
  end

  def rename_remote
    url = self.class.remote
    new_url = gsub(url)
    return if url == new_url
    `git remote rm origin`
    `git remote add origin #{new_url}`
  end

  def rename
    dir = Dir["**/#{@from}*"]
    begin
      if a = dir.pop
        b = a.split('/')
        b[-1] = gsub(b[-1])
        FileUtils.mv(a, b.join('/'))
      end
    end while dir.length > 0
  end

  def replace
    Dir["**/*"].each do |path|
      next unless File.file?(path)
      text = gsub(File.read(path))
      File.open(path, 'w') { |f| f.write(text) }
    end
  end
end