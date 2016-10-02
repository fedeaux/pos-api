child(:@reports) do
  extends 'v1/reports/base'
end

node(:available_period) do
  @available_period
end

node(:available_reporters) do
  @available_reporters
end
