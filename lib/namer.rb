$:.unshift File.dirname(__FILE__)

class Namer
  
  def initialize(args)
    path = Dir.pwd
    args.each do |arg|
      next unless arg.include?(':')
      @from, @to  = arg.split(':')
      rename         unless args.include?('--no-rename')
      replace        unless args.include?('--no-replace')
      rename_remote  unless args.include?('--no-remote')
    end
  end

  def dir(pattern)
    files =  Dir.glob(pattern, File::FNM_DOTMATCH)
    files -= %w[. ..]
    files.reject { |f| f =~ /^.git/ }
  end

  def from_regex
    /([^a-zA-Z]|^)#{@from}([^a-zA-Z]|$)/
  end

  def gsub(str)
    str.gsub(from_regex, "\\1#{@to}\\2")
  end

  def inline_gsub(str)
    return str unless split_str = str.split(/# -- replace\n/)[1]
    split_str.gsub(/^\s*#\s?/, '')
  end

  def rename_remote
    url = remote
    new_url = gsub(url)
    return if url == new_url
    `git remote rm origin`
    `git remote add origin #{new_url}`
  end

  def rename
    files = dir("**/#{@from}*")
    begin
      if a = files.pop
        b = a.split('/')
        b[-1] = gsub(b[-1])
        FileUtils.mv(a, b.join('/'))
      end
    end while files.length > 0
  end

  def remote
    `git remote show -n origin`.match(/Push\s+URL:\s+(\S+)/)[1] rescue nil
  end

  def replace
    dir("**/*").each do |path|
      next unless File.file?(path)
      text = File.read(path)
      begin
        text = gsub(text)
        text = inline_gsub(text)
      rescue Exception => e
      ensure
        File.open(path, 'w') { |f| f.write(text) }
      end
    end
  end
end