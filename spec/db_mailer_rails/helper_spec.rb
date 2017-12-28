RSpec.describe DbMailerRails::Helper do
  let(:template) { build(:db_mailer_template) }
  let(:dummy_class) { Class.new { extend DbMailerRails::Helper } }

  describe '.db_mailer_rails_fields_render' do
    it 'mail template is exists' do
      expect(dummy_class.db_mailer_rails_fields_render(nil)).to be_empty
    end

    describe 'mail template is not exists' do
      subject { dummy_class.db_mailer_rails_fields_render(template) }

      it { is_expected.to include '<ul' }
      it { is_expected.to include '<li' }
      it { is_expected.to include '</li>' }
      it { is_expected.to include '</ul>' }
    end
  end
end
