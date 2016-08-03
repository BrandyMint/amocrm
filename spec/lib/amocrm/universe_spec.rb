require 'spec_helper'

describe AmoCRM::Universe do
  let!(:client) { AmoCRM::Client.new }

  subject { described_class.new client: client }

  it 'should have a features resoruce' do
      expect(subject.features).to be_a AmoCRM::Resources::Indexed
  end

  it do
    expect(subject.features.resource).to be_a AmoCRM::Resources::Features
  end

  it do
    expect(subject.embedded_entity_metadata.resource).to be_a AmoCRM::Resources::EmbeddedEntityMetadata
  end

  it do 
    expect(subject.resources_list).to have_at_least(10).items
  end

  it do
    expect(subject.resources_list).to include(:features)
  end

  describe '.build' do
    let(:login)    { 'alala' }
    let(:password) { 'ulala' }

    subject { described_class.build login: login, password: password }

    it do
      expect(subject).to be_a AmoCRM::Universe
    end

    it do
      expect(subject.client).to be_a AmoCRM::Client
    end

  end

  describe do
    before do
      stub_rest :CustomEntityMetadata, :list, 0, './spec/fixtures/resource_forbidden.raw'
    end
    it do
      expect{subject.custom_entity_metadata.all}.to raise_error AmoCRM::Client::ResourceForbidden
    end
  end

end
