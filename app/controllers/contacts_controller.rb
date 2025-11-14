class ContactsController < ApplicationController
  before_action :set_contact, only: [ :show, :preview_template, :send_template ]

  def index
    @contacts = Contact.includes(:organization, :portfolios).order(:name)
    @email_templates = EmailTemplate.order(:id)
  end

  def show
    @email_templates = EmailTemplate.order(:id)
  end

  def preview_template
    tmpl = EmailTemplate.find_by(id: params[:template_id])
    if tmpl.nil?
      render json: { error: "Template not found" }, status: :not_found and return
    end
    rendered = tmpl.rendered_for(@contact)
    render json: rendered
  end

  def send_template
    tmpl = EmailTemplate.find_by(id: params[:template_id])
    if tmpl.nil?
      redirect_back fallback_location: contacts_path, alert: "Template not found" and return
    end

    # Basic validations
    if @contact.email.blank?
      redirect_back fallback_location: contacts_path, alert: "Contact does not have an email address" and return
    end

    # Render with TemplateRenderer
    rendered = tmpl.rendered_for(@contact)

    # Use mailer to send email (deliver_later if ActiveJob configured)
    begin
      ContactMailer.template_email(@contact.email, rendered[:subject], rendered[:body]).deliver_later
      flash[:notice] = "Email queued to be sent to #{@contact.email}"
    rescue => e
      Rails.logger.error("Mailer failed: #{e.message}\n#{e.backtrace.join("\n")}")
      # fallback: log full email in server log and show message
      Rails.logger.info("Simulated send to #{@contact.email}:\nSubject: #{rendered[:subject]}\n\n#{rendered[:body]}")
      flash[:notice] = "Mailer not configured — simulated send logged for #{@contact.email}"
    end

    redirect_back fallback_location: contacts_path
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end
end
