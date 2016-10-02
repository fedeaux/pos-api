class Report < ApplicationRecord
  serialize :reporters

  validates :start, presence: true
  validates :finish, presence: true
  validate :valid_reporters

  def valid_reporters
    if !reporters.is_a? Array
      errors.add(:reporters, 'Reporters is expected to be an array of Reporters')

    elsif reporters.empty?
      errors.add(:reporters, 'Cannot be empty')
    end
  end

  def reporters=(reporters)
    super reporters.map { |reporter|
      if reporter.is_a? String
        'Reporters::' + reporter.gsub('Reporters::', '')
      else
        reporter.name
      end
    }.reject(&:nil?)
  end

  def reporters
    names = super

    return [] unless names.is_a? Array

    names.map { |reporter_name|
      reporter_name.constantize
    }
  end

  def apply
    reporter_results = reporters.map { |klass| klass.new }

    consumptions.each do |consumption|
      reporter_results.each do |reporter_result|
        reporter_result.include consumption
      end
    end

    reporter_results.each do |reporter_result|
      reporter_result.finish
    end
  end

  def consumptions
    Consumption.where('created_at >= :start AND created_at <= :finish', start: start.beginning_of_day, finish: finish.end_of_day)
  end
end
