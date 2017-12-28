RSpec.describe 'DbMailerRails::Models', type: :model do
  subject { build(:db_mailer_template) }

  describe '#db_mailer' do
    describe 'mail template is exists' do
      let(:template) { build(:db_mailer_template) }
      it { expect(template.db_mailer).to eq(TestCaseDbMailer) }
    end

    describe 'mail template is not exists' do
      let(:template) { build(:db_mailer_template, db_mailer_class: 'NotExistsDbMailer') }
      it { expect(template.db_mailer).to be_nil }
    end
  end

  describe 'validations' do
    describe 'db_mailer_class' do
      it { should validate_presence_of(:db_mailer_class) }
      it { should validate_length_of(:db_mailer_class).is_at_least(3) }
    end

    describe 'subject' do
      it { should validate_presence_of(:subject) }
      it { should validate_length_of(:subject).is_at_least(3) }
      it { should validate_length_of(:subject).is_at_most(80) }
    end

    describe 'from' do
      it { should validate_presence_of(:from) }
      it { should validate_length_of(:from).is_at_least(3) }
      it { should validate_length_of(:from).is_at_most(64) }
    end

    describe 'to' do
      it { should validate_presence_of(:to) }
      it { should validate_length_of(:to).is_at_least(3) }
      it { should validate_length_of(:to).is_at_most(64) }
    end

    describe 'body' do
      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body).is_at_least(3) }
    end
  end
end
