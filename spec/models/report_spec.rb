require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:report_attributes) {
    {
      start: 3.weeks.ago, finish: 1.week.ago, reporters: [
                                                'Sales',
                                                'TipPerWaiter',
                                                'Products'
                                               ]
    }
  }

  describe 'validations' do
    it 'is invalid without reporters' do
      report = Report.new report_attributes.except(:reporters)
      expect(report).to be_invalid
    end

    it 'is invalid without start' do
      report = Report.new report_attributes.except(:start)
      expect(report).to be_invalid
    end

    it 'is invalid without finish' do
      report = Report.new report_attributes.except(:finish)
      expect(report).to be_invalid
    end
  end

  describe 'reporters' do
    it 'default reporters to an empty array' do
      report = Report.new report_attributes.except(:reporters)
      expect(report.reporters).to eq []
    end

    it 'can be set as strings or classes' do
      report = Report.new report_attributes.except(:reporters)
      report.reporters = ['Sales']
      expect(report.reporters.first).to eq Reporters::Sales

      report.reporters += [ Reporters::Products ]
      expect(report.reporters).to include Reporters::Products
    end
  end

  describe '#apply' do
    it 'default reporters to an empty array' do
      report = Report.new report_attributes.except(:reporters)
      expect(report.reporters).to eq []
    end

    it 'can be set as strings or classes' do
      report = Report.new report_attributes.except(:reporters)
      report.reporters = ['Sales']
      expect(report.reporters.first).to eq Reporters::Sales

      report.reporters += [ Reporters::Products ]
      expect(report.reporters).to include Reporters::Products
    end
  end
end
