require 'spec_helper'

describe RSpecLog do
  subject { described_class.new }

  describe '#initialize' do
    subject { described_class.new(filename: filename) }

    context 'filename not specified' do
      let(:filename) { nil }
      it 'defaults to DEFAULT_LOG_FILE' do
        expect(subject.instance_variable_get(:@filename)).to eq(described_class::DEFAULT_LOG_FILE)
      end
    end

    context 'filename specified' do
      let(:filename) { '/tmp/myfile' }
      it 'uses that filename' do
        expect(subject.instance_variable_get(:@filename)).to eq(filename)
      end
    end
  end

  describe '#write_file' do
    context 'filename is not specified' do
      it 'defaults to @filename and calls write_hash_to_file' do
        instance_var_filename = subject.instance_variable_get(:@filename)
        expect(described_class).to receive(:write_hash_to_file).with(anything, instance_var_filename)
        subject.write_file
      end
    end

    context 'filename specified' do
      context 'filename is nil' do
        it 'raises error' do
          expect do
            subject.write_file(filename: nil)
          end.to raise_error(/Filename is not set, you need to initialize RSpecLog before writing/)
        end
      end

      context 'filename is not nil' do
        it 'calls write_hash_to_file' do
          filename = '/tmp/myfile'
          expect(described_class).to receive(:write_hash_to_file).with(anything, filename)
          subject.write_file(filename: filename)
        end
      end
    end
  end

  describe '.print_logs_from_file' do
    let(:file_contents) { [] }
    before do
      allow(YAML).to receive(:load_file) { file_contents }
    end

    context 'filename is not specified' do
      it 'defaults to DEFAULT_LOG_FILE' do
        expect(YAML).to receive(:load_file).with(described_class::DEFAULT_LOG_FILE)
        described_class.print_logs_from_file
      end
    end

    context 'filename is specified' do
      let(:filename) { '/tmp/myfile' }

      it 'loads that file' do
        expect(YAML).to receive(:load_file).with(filename)
        described_class.print_logs_from_file(filename: filename)
      end
    end

    context 'file contents are empty' do
      it 'returns nil' do
        expect(described_class.print_logs_from_file).to eq(nil)
      end
    end

    context 'file contents are not empty' do
      let(:file_contents) { { foo: [1,2,3], bar: %w[qux abc], baz: ['a'] } }

      it 'prints the file contents' do
        expect(described_class).to receive(:puts).with('RSpecLogs: '.yellow.bold)
        file_contents.each do |key, value|
          expect(described_class).to receive(:puts).with(key)
          value.each do |content|
            expect(described_class).to receive(:puts).with(" - #{content.to_s.yellow}")
          end
        end

        described_class.print_logs_from_file
      end
    end
  end

  describe '.add_to_log' do
    before do
      allow(described_class).to receive(:current_node) { 1 }
    end

    it 'joins the key and value with a comma, calls log_hash_set' do
      key = 'key'
      value = 'value'
      example_log_hash = { 1 => ['key, value'] }
      expect(described_class).to receive(:log_hash_set).with(example_log_hash)
      described_class.add_to_log(key, value)
    end
  end
end
