class LoadMakes

    def doit()
        Make.create(name:  'Acura')
        Make.create(name:  'Audi')
        Make.create(name:  'Bentley')
        Make.create(name:  'BMW')
        Make.create(name:  'Buick')
        Make.create(name:  'Cadillac')
        Make.create(name:  'Chevrolet')
        Make.create(name:  'Chrysler')
        Make.create(name:  'Dodge')
        Make.create(name:  'Fiat')
        Make.create(name:  'Ford')
        Make.create(name:  'GMC')
        Make.create(name:  'Honda')
        Make.create(name:  'Hyundai')
        Make.create(name:  'Infiniti')
        Make.create(name:  'Jaguar')
        Make.create(name:  'Jeep')
        Make.create(name:  'Kia')
        Make.create(name:  'Land Rover')
        Make.create(name:  'Lexus')
        Make.create(name:  'Lincoln')
        Make.create(name:  'Mazda')
        Make.create(name:  'Mercedes-Benz')
        Make.create(name:  'Mini')
        Make.create(name:  'Mitsubishi')
        Make.create(name:  'Nissan')
        Make.create(name:  'Porsche')
        Make.create(name:  'Ram')
        Make.create(name:  'Scion')
        Make.create(name:  'Smart')
        Make.create(name:  'Subaru')
        Make.create(name:  'Tesla')
        Make.create(name:  'Toyota')
        Make.create(name:  'Volkswagen')
        Make.create(name:  'Volvo')
        puts "Load complete."
    end

end

l = LoadMakes.new
l.doit
