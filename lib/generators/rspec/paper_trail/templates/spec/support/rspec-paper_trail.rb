RSpec.configure do |config|
  config.include Paperclip::Shoulda::Matchers
  config.include Rspec::PaperTrailExtensions

  config.before(:each) do
    PaperTrail.enabled = false
    PaperTrail.controller_info = {}
    PaperTrail.whodunnit = nil
  end

  config.before(:each, versioning: true) do
    PaperTrail.enabled = true
  end
end

RSpec::Matchers.define :be_versioned do
  match do |actual|
    actual.respond_to?(:versions)
  end
end
