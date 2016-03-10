class LocalLogger

    @@LOGPATH = "/tmp/local.txt"

    def initialize(lp)
        @@LOGPATH = lp
    end


    def info(msg)
        open(@@LOGPATH, 'a') { |f| f.write(msg + "\n") } 
    end

end
