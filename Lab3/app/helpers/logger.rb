class Logger_
  def initialize
    @log = File.open("log/tickets.log.txt", "a")
    @@instance = Logger_.new
  end


  def self.instance
  return @@instance
  end

  def log(msg)
  @log.puts(msg)
  end

  private_class_method :new
end