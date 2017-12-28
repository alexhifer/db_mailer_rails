RSpec.describe DbMailerRails::TemplateFinder do
  let(:template) { build(:db_mailer_template) }
  let(:db_mailer_class) { template.db_mailer }

  describe '#initialize' do
    let(:template) { create(:db_mailer_template) }
    specify 'set db_mail_template attribute' do
      expect(described_class.new(template.db_mailer).db_mail_template).to eq(template)
    end
  end

  describe 'private methods' do
    describe '#find' do
      subject { described_class.new(db_mailer_class) }

      describe 'mail template exists' do
        let!(:template) { create(:db_mailer_template) }
        it { expect(subject.send(:find, template.db_mailer)).to eq(template) }
      end

      describe 'mail template not exists' do
        let(:template) { build(:db_mailer_template) }
        specify { expect { subject.send(:find, template.db_mailer) }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    describe '#db_mail_template_class' do
      let(:template) { build(:db_mailer_template) }
      before { allow_any_instance_of(described_class).to receive(:find).and_return(template) }

      it 'mail template model exists' do
        expect(described_class.new(db_mailer_class).send(:db_mail_template_class)).to eq(DbMailerTemplate)
      end

      it 'mail template model not exists' do
        expect(DbMailerRails).to receive(:template_model_class).and_return('DbMailerTemplateNotExists')
        expect(described_class.new(db_mailer_class).send(:db_mail_template_class)).to be_nil
      end
    end
  end
end
