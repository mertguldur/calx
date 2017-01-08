Given(/^I have a tenant called "(.*?)" with API access$/) do |tenant|
  @tenant = Tenant.create!(access_id: tenant)
  allow(Tenant).to receive(:find_by_access_id) { @tenant }
  allow(ApiAuth).to receive(:authentic?) { true }
end
