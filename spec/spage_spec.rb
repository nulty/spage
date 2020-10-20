require 'spec_helper'

RSpec.describe Spage do
  it 'has a version number' do
    expect(Spage::VERSION).not_to be nil
  end

  it '.config returns the Config object' do
    expect(described_class.config).to be_a(Spage::Config)
  end

  it '.configure yields the Config object' do
    expect { |blk| described_class.configure(&blk) }.to yield_with_args(Spage::Config)
  end
end
