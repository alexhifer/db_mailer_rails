RSpec.describe DbMailerRails::Base, type: :mailer do
  describe '#build' do
    let(:template) { create(:db_mailer_template) }
    let(:mail) { template.db_mailer.build(OpenStruct.new(name: 'gem DbMailerRails')) }

    describe 'rendered mail' do
      it 'renders the headers' do
        expect(mail.subject).to eq('gem DbMailerRails - Hello world!')
        expect(mail.from).to eq(['no-reply@example.com'])
        expect(mail.to).to eq(['db_mailer_rails@example.com'])
      end

      it 'renders the body' do
        expect(mail.body.encoded).to match('Hello, User!')
      end

      it 'attachments' do
        expect(mail.attachments.count).to eq(1)
      end

      it 'sends an email' do
        expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end

  specify '#fields' do
    expect(described_class.send(:new).fields).to eq({})
  end

  describe 'private methods' do
    specify '#layout' do
      expect(described_class.send(:new).send(:layout)).to eq('mailer')
    end

    describe '#layout_by_environment' do
      specify 'development environment' do
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
        expect_any_instance_of(described_class).to receive(:layout).and_return('test_mailer')
        expect(described_class.send(:new).send(:layout_by_environment)).to eq('test_mailer')
      end

      specify 'test environment' do
        expect(described_class.send(:new).send(:layout_by_environment)).to be_falsey
      end
    end

    describe '#fields_with_data' do
      let(:fields) { { user_name: 'Test' } }
      subject { described_class.send(:new) }

      specify do
        allow(subject).to receive(:user_name).and_return('Test name')
        allow(subject).to receive(:fields).and_return(fields)

        expect(subject.send(:fields_with_data)).to eq(user_name: 'Test name')
      end
    end
  end
end
