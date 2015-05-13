module ServiceLineItemsHelper

    def stypeText(st)
        return "qualification"      if st == ServiceLineItem::S_QUALIFICATION
        return "member service"     if st == ServiceLineItem::S_MEMB_SERVICE
        return "member repair"      if st == ServiceLineItem::S_MEMB_REPAIR
        return "member not covered" if st == ServiceLineItem::S_MEMB_NOT_COVERED
        return "non-member service" if st == ServiceLineItem::S_NON_MEMB_SERVICE
        return "non-member repair"  if st == ServiceLineItem::S_NON_MEMB_REPAIR
        return "other"              if st == ServiceLineItem::S_OTHER
        return "unknown"
    end

end
