class LoadStates

    def doit()
        State.create(abbrev: 'AL', name:  'Alabama ')
        State.create(abbrev: 'AK', name:  'Alaska ')
        State.create(abbrev: 'AZ', name:  'Arizona ')
        State.create(abbrev: 'AR', name:  'Arkansas ')
        State.create(abbrev: 'CA', name:  'California ')
        State.create(abbrev: 'CO', name:  'Colorado ')
        State.create(abbrev: 'CT', name:  'Connecticut ')
        State.create(abbrev: 'DE', name:  'Delaware ')
        State.create(abbrev: 'DC', name:  'District of Columbia ')
        State.create(abbrev: 'FL', name:  'Florida ')
        State.create(abbrev: 'GA', name:  'Georgia ')
        State.create(abbrev: 'HI', name:  'Hawaii ')
        State.create(abbrev: 'ID', name:  'Idaho ')
        State.create(abbrev: 'IL', name:  'Illinois ')
        State.create(abbrev: 'IN', name:  'Indiana ')
        State.create(abbrev: 'IA', name:  'Iowa ')
        State.create(abbrev: 'KS', name:  'Kansas ')
        State.create(abbrev: 'KY', name:  'Kentucky ')
        State.create(abbrev: 'LA', name:  'Louisiana ')
        State.create(abbrev: 'ME', name:  'Maine ')
        State.create(abbrev: 'MD', name:  'Maryland ')
        State.create(abbrev: 'MA', name:  'Massachusetts ')
        State.create(abbrev: 'MI', name:  'Michigan ')
        State.create(abbrev: 'MN', name:  'Minnesota ')
        State.create(abbrev: 'MS', name:  'Mississippi ')
        State.create(abbrev: 'MO', name:  'Missouri ')
        State.create(abbrev: 'MT', name:  'Montana ')
        State.create(abbrev: 'NE', name:  'Nebraska ')
        State.create(abbrev: 'NV', name:  'Nevada ')
        State.create(abbrev: 'NH', name:  'New Hampshire ')
        State.create(abbrev: 'NJ', name:  'New Jersey ')
        State.create(abbrev: 'NM', name:  'New Mexico ')
        State.create(abbrev: 'NY', name:  'New York ')
        State.create(abbrev: 'NC', name:  'North Carolina ')
        State.create(abbrev: 'ND', name:  'North Dakota ')
        State.create(abbrev: 'OH', name:  'Ohio ')
        State.create(abbrev: 'OK', name:  'Oklahoma ')
        State.create(abbrev: 'OR', name:  'Oregon ')
        State.create(abbrev: 'PA', name:  'Pennsylvania ')
        State.create(abbrev: 'RI', name:  'Rhode Island ')
        State.create(abbrev: 'SC', name:  'South Carolina ')
        State.create(abbrev: 'SD', name:  'South Dakota ')
        State.create(abbrev: 'TN', name:  'Tennessee ')
        State.create(abbrev: 'TX', name:  'Texas ')
        State.create(abbrev: 'UT', name:  'Utah ')
        State.create(abbrev: 'VT', name:  'Vermont ')
        State.create(abbrev: 'VA', name:  'Virginia ')
        State.create(abbrev: 'WA', name:  'Washington ')
        State.create(abbrev: 'WV', name:  'West Virginia ')
        State.create(abbrev: 'WI', name:  'Wisconsin ')
        State.create(abbrev: 'WY', name:  'Wyoming ')
        puts "Load complete."
    end

end

l = LoadStates.new
l.doit
