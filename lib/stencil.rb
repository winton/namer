$:.unshift File.dirname(__FILE__)

class Stencil
  
  def initialize(args)
    path = Dir.pwd
    args.each do |arg|
      next unless arg.include?('->')
      from, to = arg.split('->')
      rename(from, to)
      replace(from, to)
      remote(from, to)
    end
  end

  def remote(from, to)
    url = `git remote show -n origin`.match(/Push\s+URL:\s+(\S+)/)[1] rescue nil
    new_url = url.gsub(from, to)
    return if url == new_url
    `git remote rm origin`
    `git remote add origin #{new_url}`
  end

  def rename(from, to)
    dir = Dir["**/#{from}*"]
    begin
      if a = dir.pop
        b = a.split('/')
        b[-1].gsub!(from, to)
        FileUtils.mv(a, b.join('/'))
      end
    end while dir.length > 0
  end

  def replace(from, to)
    Dir["**/*"].each do |path|
      next unless File.file?(path)
      text = File.read(path).gsub(from, to)
      File.open(path, 'w') { |f| f.write(text) }
    end
  end
end