class AddressData
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def format_data(string)
    return {} if string.blank?
    date, time, address_data = string.split(/ /)
    data = JSON.parse(address_data)
    formated = Helper.downcase(data)
    formated.merge!(date: date, time: time)
    OpenStruct.new(formated)
  end

  def populate
    header
    return message(:error) unless File.exists?(file)
      File.readlines(file).each do |line|
        address = format_data(line)
        Address.create(address.to_h)
      end
      message(:success)
  end

  private

  def message(args={})
    case args
      when :success
        puts  %Q{
            ******************************
            DB was successfully populated
            ******************************
            }.green
      when :error
        puts %Q{
          File:  #{file}  was not found
          ***********************************
          DB was not populated with addresses
          }.red
    end
  end

  def header
    puts "*********************************"
    puts "Populating db with addresses data"
    puts "*********************************"
  end
end

class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end

end
