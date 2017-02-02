require 'spec_helper'

RSpec.describe Tomograph::Tomogram do
  describe '#json' do
    subject { JSON.parse(described_class.json) }
    let(:parsed) { MultiJson.load(File.read(json_schema)) }

    before do
      allow(Rails).to receive(:root).and_return("#{ENV['RBENV_DIR']}/spec/fixtures")
    end

    context 'if one action' do
      let(:json_schema) { 'spec/fixtures/api2.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api2.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'additional desription' do
      let(:json_schema) { 'spec/fixtures/api16.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api16.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'if two actions' do
      let(:json_schema) { 'spec/fixtures/api3.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api3.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'if two controllers and three actions' do
      let(:json_schema) { 'spec/fixtures/api4.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api4.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'blank request' do
      let(:json_schema) { 'spec/fixtures/api5.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api5.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'action with comment' do
      let(:json_schema) { 'spec/fixtures/api6.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api6.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'action with his unique path' do
      let(:json_schema) { 'spec/fixtures/api7.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api7.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'if there is a description of the project' do
      context 'action with his unique path' do
        let(:json_schema) { 'spec/fixtures/api8.json' }

        before do
          allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api8.yaml', prefix: ''))
        end

        it 'parses documents' do
          expect(subject).to eq(parsed)
        end
      end

      context 'action with his unique path' do
        let(:json_schema) { 'spec/fixtures/api9.json' }

        before do
          allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api9.yaml', prefix: ''))
        end

        it 'parses documents' do
          expect(subject).to eq(parsed)
        end
      end
    end

    context 'if the structure of the first' do
      let(:json_schema) { 'spec/fixtures/api10.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api10.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'if the structure of the first' do
      let(:json_schema) { 'spec/fixtures/api11.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api11.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'if two response with the same code' do
      let(:json_schema) { 'spec/fixtures/api12.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api12.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'if you forget to specify the type of response' do
      let(:json_schema) { 'spec/fixtures/api13.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api13.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'if you with to specify the type of request' do
      let(:json_schema) { 'spec/fixtures/api14.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api14.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'if you with to specify the type of response' do
      let(:json_schema) { 'spec/fixtures/api15.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api15.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'with request body' do
      let(:json_schema) { 'spec/fixtures/api_builtin_scheme.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api_builtin_scheme.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end

    context 'with a broken schema' do
      let(:json_schema) { 'spec/fixtures/api_with_broken_schema.json' }

      before do
        allow(Tomograph).to receive(:configuration).and_return(double(documentation: 'api_with_broken_schema.yaml', prefix: ''))
      end

      it 'parses documents' do
        expect(subject).to eq(parsed)
      end
    end
  end

  describe '#delete_query_and_last_slash' do
    context 'if without query' do
      let(:path) { '/status/' }
      let(:stump) { '/status' }

      it 'no changes' do
        expect(described_class.delete_query_and_last_slash(path)).to eq(stump)
      end
    end

    context 'if there is' do
      let(:path1) { '/status/{&search}{&page}' }
      let(:path2) { '/status/{?search,page}' }
      let(:stump) { '/status' }

      it 'delete query' do
        expect(described_class.delete_query_and_last_slash(path1)).to eq(stump)
        expect(described_class.delete_query_and_last_slash(path2)).to eq(stump)
      end

      context 'and a parameter' do
        let(:path1) { '/users/{id}/pokemons/{&search}{&page}' }
        let(:path2) { '/users/{id}/pokemons/{?search,page}' }
        let(:stump) { '/users/{id}/pokemons' }

        it 'delete query' do
          expect(described_class.delete_query_and_last_slash(path1)).to eq(stump)
          expect(described_class.delete_query_and_last_slash(path2)).to eq(stump)
        end
      end
    end
  end
end
