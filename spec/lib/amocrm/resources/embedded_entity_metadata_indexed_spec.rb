require 'spec_helper'

describe AmoCRM::Resources::EmbeddedEntityMetadataIndexed do

  let(:article_uuid) { 'dc410ce3-505a-11e4-90a2-8eca00496371' }

  before do
    stub_rest :EmbeddedEntityMetadata, :list, 0
  end

  describe 'subresource' do
    let(:metadata_resource) { AmoCRM::Resources::EmbeddedEntityMetadata.indexed client: client }
    subject { metadata_resource.subresource_by_name :GoodFolder }

    it { expect(subject).to be_a AmoCRM::Resources::Subresource }
    it { expect(subject.items.first).to be_a AmoCRM::Entities::AttributeMetadata }

  end

end
