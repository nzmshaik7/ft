class Gengraph

    require 'socket'

    @@GRAPHDIR = "public/graphs"
    @@HOST = 'localhost'
    @@PORT = 7001
    @@LOCALLOG = nil


    def initialize(locallog)
        @graphUrls = Hash.new
        if locallog 
            @@LOCALLOG = locallog 
            # open('/tmp/YN', 'w') { |f| f.write("YES\n") } 
        end
    end


    def llog(msg)
        if @@LOCALLOG
            @@LOCALLOG.info(msg)
        end
    end


    def requestPlot?(name, imageFile, data)
        begin
            # llog("==== requestPlot #{name}")
            s = TCPSocket.open(@@HOST, @@PORT)
            s.write "#{name},#{imageFile}\n"
            s.write data
            s.shutdown(Socket::SHUT_WR)
            resp = s.read
            # llog("==== requestPlot resp is #{resp}")
            if resp[0..1] == 'OK'
                return true
            else
                llog("==== Plot #{name} failed: #{resp}")
                return false
            end
        rescue
            llog("==== Plot #{name} got exception")
            return false
        end
         
    end


    def clubFeesPie(veh, membClubFees, membScheduled, membUnscheduled)

        # scheduled,unscheduled,gross 
        imgfile = "clubfeespie-#{veh.id}.png"
        graphPath = Rails.root.join(@@GRAPHDIR).to_s
        clubfeespie = "#{graphPath}/#{imgfile}"
        grossProfit = membClubFees - (membScheduled + membUnscheduled)

        if grossProfit < 0.0
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


    def profitabilityPie(veh, totalIncome, totalPartsCost, totalLaborCost)

        imgfile = "totprofpie-#{veh.id}.png"
        graphPath = Rails.root.join(@@GRAPHDIR).to_s
        piePath = "#{graphPath}/#{imgfile}"
        netProfit = totalIncome - (totalPartsCost + totalLaborCost)

        if netProfit < 0.0
            netProfit = 0 - netProfit 
            data = "#{totalLaborCost},#{totalPartsCost},#{netProfit}\n"
            worked = requestPlot?('totproflosspie', piePath, data)
        else
            data = "#{totalLaborCost},#{totalPartsCost},#{netProfit}\n"
            worked = requestPlot?('totprofpie', piePath, data)
        end
        if worked
            @graphUrls['totprofpie'] = "/graphs/#{imgfile}"
        else
            @graphUrls['totprofpie'] = "/assets/gen/ploterr.png"
        end

    end


    def getUrls
        return @graphUrls
    end

end
