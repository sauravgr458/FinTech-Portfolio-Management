class ContactMailer < ApplicationMailer
  default from: -> { default_sender_email }

  def template_email(to_email, subject, body)
    mail(to: to_email, subject: subject) do |format|
      format.text { render plain: body }
    end
  end

  private

  def default_sender_email
    'no-reply@example.com'
  end
end
