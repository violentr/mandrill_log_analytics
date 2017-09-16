RSpec.describe AddressData do
  let(:file_path) { Rails.root + 'db/mandrill.log'}
  let(:file_doesnt_exist) { 'somefile.txt' }


  context 'When db was populated' do

    before do
      @address_data = AddressData.new(file_path)
    end

    it "should have valid file" do
      expect(@address_data.file).to be
    end

    it "should have content in a file" do
      expect(@address_data.file).not_to be_blank
    end

    it "should have data in a specific format" do
      string = "2017/09/14 18:08:41 {\"Address\":\"barney@lostmy.name\",\"EmailType\":\"Shipment\",\"Event\":\"send\",\"Timestamp\":1505408921}\n"
      file = File.readlines(@address_data.file)
      expect(file.first).to eq(string)
    end

    it "should be formated as OpenStruct object(:address, :emailtype, :event, :timestamp) with data" do
      string = "2017/09/14 18:08:41 {\"Address\":\"barney@lostmy.name\",\"EmailType\":\"Shipment\",\"Event\":\"send\",\"Timestamp\":1505408921}\n"
      output = @address_data.format_data(string)
      expect(output).to be_a(OpenStruct)
      output.each do |key|
        expect(output.to_h)[key.to_sym].to be
      end
    end

    it "should have record in DB" do
      @address_data.populate
      expect(Address.first).to be
    end
  end

  context 'When data was not populated' do

    it "should not populate db with records" do
     AddressData.new(file_doesnt_exist).populate
      expect(Address.count).to eq 0
    end

  end
end
