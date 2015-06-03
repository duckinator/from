require 'spec_helper'

# NOTE: Kernel.from() is nothing except a call to Kernel.require() and From.new().
#   We assume require() works, so testing the From class covers everything.

RSpec.describe From do
  let(:fake_path)   { "some_library/test_file" }
  let(:fake_path_allcaps) { "some_library/test_file/allcaps"}
  let(:fake_module) { Module.new }
  let(:fake_module_allcaps) { Module.new }
  let(:fake_module_b) { Module.new }

  subject { From.new(fake_path) }

  before do
    allow(fake_module).to receive(:works?) { true }

    stub_const("SomeLibrary::TestFile", fake_module)
    stub_const("SomeLibrary::TestFile::ALLCAPS", fake_module_allcaps)
    stub_const("SomeLibrary::TestFile::B", fake_module_b)
  end

  context '#module_from_path' do
    it 'resolves a module from a path name' do
      expect(subject.send(:module_from_path, fake_path_allcaps)).to be(fake_module_allcaps)
    end
  end
end
