require 'spec_helper'

# NOTE: Kernel.from() is nothing except a call to Kernel.require() and From.new().
#   We assume require() works, so testing the From class covers everything.

RSpec.describe From do
  let(:collector) { Module.new }

  let(:fake_path)   { "some_library/test_file" }
  let(:fake_path_a) { "some_library/test_file/a"}
  let(:fake_module) { Module.new }
  let(:fake_module_a) { Module.new }
  let(:fake_module_b) { Module.new }

  subject { From.new(fake_path) }

  before do
    stub_const("SomeLibrary::TestFile", fake_module)
    stub_const("SomeLibrary::TestFile::A", fake_module_a)
    stub_const("SomeLibrary::TestFile::B", fake_module_b)
  end

  context '#module_from_path' do
    it 'resolves a module from a path name' do
      expect(subject.send(:module_from_path, fake_path_a)).to be(fake_module_a)
    end
  end

  context '#import' do
    it 'returns the specified constants' do
      from_instance = From.new('some_library/test_file')

      expect(from_instance.import(:A, :B)).to eq([
        SomeLibrary::TestFile::A,
        SomeLibrary::TestFile::B,
      ])
    end
  end

  context '#include' do
    it 'includes the specified constants to the specified object' do
      subject.include(:A, :B)

      expect(A).to be(fake_module_a)
      expect(B).to be(fake_module_b)
    end
  end
end
