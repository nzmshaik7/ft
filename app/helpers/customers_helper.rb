module CustomersHelper

    # A customer may or may not be a User.  Try Customer field
    # first, then try User.
    def customerName2(cust)
        return ''  if cust.nil?
        if cust.first_name and cust.first_name.length > 1
            return cust.first_name + ' ' + cust.last_name 
        elsif cust.user
            return cust.user.first_name + ' ' + cust.user.last_name
        else
            return 'EMPTY'
        end
    end

    def referredBy(cust)
        answer = '<i>None</i>'
        delim = ''
        if cust.referredBy_id
            answer = cust.referredBy.description
            delim = ': '
            if not cust.referredBy.isNone
                if cust.referredBy_other_text and 
                                          cust.referredBy_other_text.length > 1 
                    answer += delim + cust.referredBy_other_text
                end
            end
        end
        return answer
    end

end
