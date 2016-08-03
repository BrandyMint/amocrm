require 'spec_helper'

describe AmoCRM::Resources do
  it 'should be loaded' do
    expect(AmoCRM::Resources).to be_a Module

    expect(AmoCRM::Resources.resources).to include(AmoCRM::Resources::Features)
    expect(AmoCRM::Resources.resources).to include(AmoCRM::Resources::EmbeddedEntityMetadata)
  end
end
