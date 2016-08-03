require 'spec_helper'

describe AmoCRM::Resources::GoodFolders do

  it 'should be GoodFolder' do
    expect(described_class.entity_class).to eq AmoCRM::Entities::GoodFolder
  end

  describe 'resource' do
    subject { AmoCRM::Resources::GoodFolders.new client: client }

    it 'should get item' do
      expect(subject.send(:list_path)).to  eq "exchange/rest/ms/xml/GoodFolder/list"
    end
  end

end
