module QualificationsHelper

    # Database might not have cylinders in order
    # 
    def prepCylinders(qual, min_cyl=0)
        @compressions = Array.new
        @compPct = Array.new
        @last_compression = min_cyl
        for c in 1..@last_compression
            @compressions[c] = nil
        end
        if qual
            for x in 1..12
                for cc in qual.cylinder_compressions
                    if cc.cyl_num == x
                        @compressions[x] = cc.psi
                        delta = qual.cylinder_compression_spec - cc.psi
                        if delta < 0
                            delta = -delta
                        end
                        @compPct[x] = 
                                 100.0 * delta / qual.cylinder_compression_spec
                        if @last_compression < x
                            @last_compression = x
                        end
                        break
                    end
                end
            end
        end
    end

end
