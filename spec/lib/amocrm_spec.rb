require 'spec_helper'

describe AmoCRM do
  it 'should be loaded' do
    expect(AmoCRM::Entities::Base).to  be_a Class
    expect(AmoCRM::Entities::Company).to be_a Class
  end
end
