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
      render json: { error: "Template not found" }, status: :not_found
      return
    end
    rendered = tmpl.rendered_for(@contact)
    render json: rendered
  end

  def send_template
    tmpl = EmailTemplate.find_by(id: params[:template_id])
    if tmpl.nil?
      redirect_back fallback_location: contacts_path, alert: "Template not found"
      return
    end
    rendered = tmpl.rendered_for(@contact)
    Rails.logger.info("=======================================================================")
    Rails.logger.info("Simulated email send to #{@contact.email}: #{rendered[:subject]}")
    Rails.logger.info("=======================================================================")
    flash[:notice] = "Email to #{@contact.email} simulated (check logs)."
    redirect_back fallback_location: contacts_path
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end
end
