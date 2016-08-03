require 'spec_helper'

describe AmoCRM::Client::Errors do
  it 'should be loaded' do
    expect(AmoCRM::Resources).to be_a Module

    expect(AmoCRM::Resources.resources).to include(AmoCRM::Resources::Features)
  end

  describe 'catch errors' do

    let(:resource) { AmoCRM::Resources::CustomEntityMetadata.new client: client }
    let(:file) { raise 'not setted' }
    let(:url)  { 'http://fake.url/' }
    let(:result) { Faraday.new( url ).get '/' }

    subject do
      described_class.build result
    end
    
    before do
      #AmoCRM::Client::ParsedError
      stub_request(:get, url).to_return File.new( './spec/fixtures/' + file + '.raw' )
    end

    context 'bad gateway' do
      let(:file) { '502' }
      let(:error) { AmoCRM::Client::BadGatewayError }
      it { expect{subject}.to raise_error error }
    end

    context 'internal server error' do
      let(:file) { '500' }
      let(:error) { AmoCRM::Client::InternalServerError }
      it { expect{subject}.to raise_error error }
    end

    context 'wrong_user' do
      let(:file) { 'wrong_user' }

      let(:error) { AmoCRM::Client::UnauthorizedError }

      it { expect{subject}.to raise_error error }
    end
    
    context 'wrong_password' do
      let(:file) { 'wrong_password' }
      let(:error) { AmoCRM::Client::UnauthorizedError }

      it { expect{subject}.to raise_error error }
    end

    context 'wrong_type' do
      let(:file) { 'wrong_type' }
      let(:error) { AmoCRM::Client::ParsedError }

      it { expect{subject}.to raise_error error }
    end

    context 'resource_forbidden' do
      let(:file) { 'resource_forbidden' }
      let(:error) { AmoCRM::Client::ResourceForbidden }

      it { expect{subject}.to raise_error error }
    end

    describe 'encoding' do
      context 'forbidden' do
        let(:file) { 'resource_forbidden' }

        subject do
          AmoCRM::Client::ResourceForbidden.new result
        end

        it { expect(subject.message).to eq '[403] JBWEB000065: HTTP Status 403 - ; JBWEB000123: Access to the specified resource has been forbidden.' }
        it { expect(subject.message.encoding).to eq Encoding::UTF_8 }
      end
      context 'wront_type' do
        let(:file) { 'wrong_type' }

        subject do
          AmoCRM::Client::ParsedError.new result
        end

        it { expect(subject.message).to eq 'Wrong type: Unknown2' }
        it { expect(subject.message.encoding).to eq Encoding::UTF_8 }
      end
      context 'wrong_password' do
        let(:file) { 'wrong_password' }

        subject do
          AmoCRM::Client::UnauthorizedError.new result
        end

        it { expect(subject.message).to eq '[401] JBWEB000065: HTTP Status 401 - Неправильный пароль или имя пользователя; JBWEB000121: This request requires HTTP authentication.' }
        it { expect(subject.message.encoding).to eq Encoding::UTF_8 }
      end
    end
  end


end
