require 'rails_helper'

RSpec.describe Address, type: :model do
   it {is_expected.to respond_to(:address) }
   it {is_expected.to respond_to(:emailtype) }
   it {is_expected.to respond_to(:event) }
   it {is_expected.to respond_to(:timestamp) }
   it {is_expected.to respond_to(:date) }
   it {is_expected.to respond_to(:time) }

end
