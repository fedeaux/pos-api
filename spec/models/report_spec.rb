require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:report_attributes) { attributes_for :report  }

  describe 'factories' do
    it 'has a valid factory' do
      expect(create :report).to be_valid
    end
  end

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

  describe 'consumptions' do
    let(:report) { Report.create report_attributes }

    before(:each) {
      create :product_food
      create :product_food
      create :product_drink
      Table.ensure_amount 1
    }

    it 'returns the consumptions on the period' do
      expect(report.consumptions.count).to eq 0

      create_pseudo_random_consumptions_on_range report_attributes[:start], report_attributes[:finish]

      on_range_consumption_count = Consumption.count
      expect(report.consumptions.count).to eq on_range_consumption_count

      # Create some consumptions out of range
      create_pseudo_random_consumptions_on_range (report_attributes[:start] - 2.weeks), (report_attributes[:start] - 1.week)
      expect(report.consumptions.count).to eq on_range_consumption_count
    end
  end
end
