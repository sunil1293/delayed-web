require 'spec_helper'

describe Delayed::Web::JobsHelper do
  let(:executing_job) { double 'Delayed::Job', locked_at: Time.current, locked_by: 'host.local' }
  let(:failed_job)    { double 'Delayed::Job', locked_at: nil, locked_by: nil, attempts: 1, last_error: 'RuntimeError: RuntimeError' }
  let(:queued_job)    { double 'Delayed::Job', locked_at: nil, locked_by: nil, attempts: 0, last_error: '' }

  describe '#status_text' do
    it 'is executing' do
      text = helper.status_text executing_job

      expect(text).to eq('executing')
    end

    it 'is failed' do
      text = helper.status_text failed_job

      expect(text).to eq('failed')
    end

    it 'is failed' do
      text = helper.status_text queued_job

      expect(text).to eq('queued')
    end
  end

  describe '#status_dom_class' do
    it 'is badge warning' do
      dom_class = helper.status_dom_class executing_job

      expect(dom_class).to eq('badge badge-warning')
    end

    it 'is badge important' do
      dom_class = helper.status_dom_class failed_job

      expect(dom_class).to eq('badge badge-important')
    end

    it 'is badge' do
      dom_class = helper.status_dom_class queued_job

      expect(dom_class).to eq('badge')
    end
  end
end