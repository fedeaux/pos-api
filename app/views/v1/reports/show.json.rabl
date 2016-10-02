child(:@report) do
  extends 'v1/reports/base'
end

node(:results) do
  @results
end
