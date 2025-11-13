class EmailTemplate < ApplicationRecord
  validates :subject, :body, presence: true

  # Return a preview by rendering with provided contact
  def rendered_for(contact)
    TemplateRenderer.new(self, contact).render
  end
end
