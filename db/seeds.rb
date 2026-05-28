puts "Clearing existing data..."

MaintenanceRecord.destroy_all
Equipment.destroy_all
Category.destroy_all


puts "Seeding categories..."
computing = Category.create!(name: "Computing")
networking = Category.create!(name: "Networking")
optics = Category.create!(name: "Optics")
electronics = Category.create!(name: "Electronics")


puts "Creating Equipment..."
eq1 = Equipment.create!(category: computing, name: "MacBook Pro M2", serial_number: "MAC-001", status: "available")
eq2 = Equipment.create!(category: computing, name: "DELL XPS 15", serial_number: "MAC-002", status: "in_use")

eq3 = Equipment.create!(category: optics, name: "Zeiss Microscope", serial_number: "OPT-100", status: "maintenance")
eq4 = Equipment.create!(category: optics, name: "Laser Calibration Tool", serial_number: "LSR-999", status: "available")

eq5 = Equipment.create!(category: networking, name: "Cisco Switch", serial_number: "NET-042", status: "in_use")
eq6 = Equipment.create!(category: networking, name: "Netgear Router", serial_number: "RTR-001", status: "available")

eq7 = Equipment.create!(category: electronics, name: "Arduino Uno", serial_number: "ARD-001", status: "available")
eq8 = Equipment.create!(category: electronics, name: "Raspberry Pi 4", serial_number: "RAS-004", status: "available")

puts "Seeding Maintenance Records..."
MaintenanceRecord.create!(equipment: eq3, description: "Replaced faulty lens.", performed_at: 2.days.ago)
MaintenanceRecord.create!(equipment: eq3, description: "Annual calibration.", performed_at: 1.month.ago)


MaintenanceRecord.create!(equipment: eq5, description: "Firmware update to v2.1.", performed_at: 1.week.ago)
MaintenanceRecord.create!(equipment: eq5, description: "Port 4 configuration fix.", performed_at: 3.months.ago)

MaintenanceRecord.create!(equipment: eq2, description: "Battery replacement.", performed_at: 5.days.ago)

puts "Seeding completed successfully!"
puts "Categories: #{Category.count}"
puts "Equipment: #{Equipment.count}"
puts "Maintenance Records: #{MaintenanceRecord.count}"
