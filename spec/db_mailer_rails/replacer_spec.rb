RSpec.describe DbMailerRails::Replacer do
  let(:replace_hash) { { test_attr: 'DbMailerRails' } }
  subject { described_class.new(replace_hash) }

  specify '#initialize' do
    expect(subject.replace_hash).to eq(replace_hash)
  end

  specify '#replace' do
    expect(subject.replace('Hello, {{test_attr}}')).to eq("Hello, #{replace_hash[:test_attr]}")
  end
end
