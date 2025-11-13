class TemplateRenderer
  # Accepts EmailTemplate instance and Contact (required)
  def initialize(email_template, contact)
    @template = email_template
    @contact = contact
    @org = contact.organization
  end

  # Render subject and body into a hash { subject: '', body: '' }
  def render
    { subject: render_text(@template.subject), body: render_text(@template.body) }
  end

  private

  TOKEN_MAP = {
    "Contact.name" => ->(c, o) { c.name },
    "Contact.email" => ->(c, o) { c.email },
    "Organization.name" => ->(c, o) { o.name },
    "Organization.email" => ->(c, o) { o.email },
    "Portfolio.best_performance" => ->(c, o) { format_perf(c.best_portfolio_performance) },
    "Portfolio.worst_performance" => ->(c, o) { format_perf(c.worst_portfolio_performance) }
  }.freeze

  def render_text(text)
    return "" unless text
    out = text.dup
    # Replace tokens like {Contact.name}
    out.gsub(/\{([^\}]+)\}/) do |match|
      key = $1.strip
      if TOKEN_MAP[key]
        begin
          TOKEN_MAP[key].call(@contact, @org).to_s
        rescue => e
          "[error: #{key}]"
        end
      else
        # Unknown token: keep as-is or show placeholder
        "{#{key}}"
      end
    end
  end

  def self.format_perf(val)
    return "N/A" if val.nil?
    # Ensure it's shown with up to 2 decimals, drop trailing zeros
    sprintf("%.2f", val).sub(/\.00$/, "")
  end

  # instance-level helper
  def format_perf(val)
    self.class.format_perf(val)
  end
end
