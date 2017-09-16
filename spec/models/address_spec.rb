require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:file_name) { Rails.root + 'db/mandrill.log'}
  let(:uniq_email_types) {["shipment", "userconfirmation", "order", "getabookdiscount", "referafriend"]}
   it {is_expected.to respond_to(:address) }
   it {is_expected.to respond_to(:emailtype) }
   it {is_expected.to respond_to(:event) }
   it {is_expected.to respond_to(:timestamp) }
   it {is_expected.to respond_to(:date) }
   it {is_expected.to respond_to(:time) }

   %w(opened clicked sent).each do |event| 
     it "should have scope #{event}" do
       expect(described_class.send(event.to_sym)).to be
     end
   end

   it "should have uniq_email_types" do
     AddressData.new(file_name).populate
     expect(described_class.uniq_email_types).to eq uniq_email_types
   end
end
