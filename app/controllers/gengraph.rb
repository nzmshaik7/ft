class Gengraph

    require 'socket'

    @@GRAPHDIR = "public/graphs"
    @@HOST = 'localhost'
    @@PORT = 7001


    def initialize()
        @graphUrls = Hash.new
    end


    def requestPlot?(name, imageFile, data)
        begin
            s = TCPSocket.open(@@HOST, @@PORT)
            s.write "#{name},#{imageFile}\n"
            s.write data
            s.shutdown(Socket::SHUT_WR)
            resp = s.read
            if resp[0..1] == 'OK'
                return true
            else
                return false
            end
        rescue
            return false
        end
         
    end


    def clubfeespie(veh, membClubFees, membScheduled, membUnscheduled)

        # scheduled,unscheduled,gross 
        imgfile = "clubfeespie-#{veh.id}.png"
        graphPath = Rails.root.join(@@GRAPHDIR).to_s
        clubfeespie = "#{graphPath}/#{imgfile}"
        grossProfit = membClubFees - (membScheduled + membUnscheduled)

        if grossProfit < 0
            grossProfit = 0 - grossProfit 
            data = "#{membScheduled},#{membUnscheduled},#{grossProfit}\n"
            worked = requestPlot?('clubfeesloss', clubfeespie, data)
        else
            data = "#{membScheduled},#{membUnscheduled},#{grossProfit}\n"
            worked = requestPlot?('clubfeesprof', clubfeespie, data)
        end
        if worked
            @graphUrls['clubfeespie'] = "/graphs/#{imgfile}"
        else
            @graphUrls['clubfeespie'] = "/assets/gen/ploterr.png"
        end

    end


    def getUrls
        return @graphUrls
    end

end
