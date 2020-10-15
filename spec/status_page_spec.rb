require 'spec_helper'

RSpec.describe StatusPage do
  it 'has a version number' do
    expect(StatusPage::VERSION).not_to be nil
  end

  it '.config returns the Config object' do
    expect(described_class.config).to be_a(StatusPage::Config)
  end

  it '.configure yields the Config object' do
    expect { |blk| described_class.configure(&blk) }.to yield_with_args(StatusPage::Config)
  end
end
