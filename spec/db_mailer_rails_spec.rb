RSpec.describe DbMailerRails do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  it 'set default attributes' do
    expect(described_class.template_model_class).to eq('DbMailerTemplate')
    expect(described_class.sync_file_path).to eq('config/db_mailer_templates.yml')
  end

  describe '.setup' do
    it 'set attibute with block' do
      expect(described_class.template_model_class).to eq('DbMailerTemplate')
      allow(described_class).to receive(:template_model_class).and_return('MailTemplate')
      expect(described_class.template_model_class).to eq('MailTemplate')
    end
  end
end
