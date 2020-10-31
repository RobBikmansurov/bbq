require 'rails_helper'

RSpec.describe EventPhotoNotifyJob, type: :job do
  subject(:job) { described_class.perform_later(key) }

  let(:key) { 1 }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
      .with(1)
      .on_queue(:default)
  end
end
