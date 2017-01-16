task calx_client: :environment do
  require 'irb'
  require 'irb/completion'
  require 'calx_client'

  def reload!
    files = $LOADED_FEATURES.select { |feat| feat =~ %r{\/calx_client\/} }
    files.each { |file| load file }
  end

  def start_client(tenant)
    reload!
    tenant ||= Tenant.first
    CalX::Client.new(tenant.access_id, tenant.secret_key)
  end

  ARGV.clear
  IRB.start
end
