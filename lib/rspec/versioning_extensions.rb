module RspecExtensions
  # :call-seq:
  # with_versioning
  #
  # enable versioning for specific blocks

  def with_versioning
    was_enabled = PaperTrail.enabled?
    PaperTrail.enabled = true
    begin
      yield
    ensure
      PaperTrail.enabled = was_enabled
    end
  end
end

RSpec.configure do |config|
  config.include RspecExtensions

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

